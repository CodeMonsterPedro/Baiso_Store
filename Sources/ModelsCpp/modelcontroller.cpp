#include "../../Headers/Models/modelcontroller.h"

ModelController::ModelController(QObject *parent) : QObject(parent),m_myModel(new InformationListModel())
{
    PlanCheck();
    m_myModel = new InformationListModel();
    m_myPlan = new InformationListModel();
    maxPageCount=currentPageCount=0;
    m_list = new QStringList;
    *m_list = RepositoryU::tables;
    m_list->pop_front();
    emit listChanged();
    QObject::connect(m_myModel,SIGNAL(dataChanged()),this,SLOT(onDataChanged()));
}

ModelController::~ModelController(){
    delete m_myModel;
    delete m_myPlan;
}
//data getters
InformationListModel* ModelController::myModel(){
    return m_myModel;
}
InformationListModel* ModelController::myPlan(){
    return m_myPlan;
}
QStringList ModelController::list(){
    return *m_list;
}
int ModelController::maxPage(){
    return maxPageCount;
}
int ModelController::currentPage(){
    return currentPageCount;
}

void ModelController::PlanCheck()
{
    QSqlQuery tempq = RepositoryU::GetRequest(QString("SELECT bar_code, product_name FROM public.\"ProductList\""));
    QSqlQuery tempq2 = RepositoryU::GetRequest(QString("SELECT \"bar-code\" FROM public.\"ProductPlan\""));
    QStringList strl;
    while (tempq2.next()) {
        strl.append(tempq2.record().value(tempq2.record().indexOf("bar-code")).toString());
    }
    while (tempq.next()) {
        if(strl.contains(tempq.record().value(tempq.record().indexOf("bar_code")).toString()))continue;
        else {
            RepositoryU::SetRequest(QString("INSERT INTO public.\"ProductPlan\"(\"product\",\"bar-code\",\"count\") VALUES('%1','%2',0)")
                                    .arg(tempq.record().value(tempq.record().indexOf("product_name")).toString())
                                    .arg(tempq.record().value(tempq.record().indexOf("bar_code")).toString()));
        }
    }
}
//main functions
void ModelController::showFrom(int source)
{
    m_myModel->showfrom(source);
    setMyModel(m_myModel);
    setMaxPage(m_myModel->maxPage);
    setCurrentPage(1);
    //setcCnt();
    //setcolName();
}

void ModelController::showFromPlan(int source)
{
    m_myPlan->showfrom(source);
    setMyPlan(m_myPlan);
    setMaxPage(m_myPlan->maxPage);
    setCurrentPage(1);
}

int ModelController::addNewElementToRep(QString str){

    //return RepositoryU::SetRequest(str);
    //INSERT INTO public."ProductList"("product_name","In_box_count","supplyer","company","price","count_sys","bar_code","last_suplyed") VALUES('Igor',1,'Igor1','irog3',2.5,(0/1),'',2.2019);
    //INSERT INTO public."ProductSaleFull"("product_name","market_Id","purchase_Id","product_count","price","date") VALUES('Igor',1,1,1,2.5,2.2019);
    QStringList strl = str.split('|');
    if(strl.size()==8){
        RepositoryU::SetRequest(QString("INSERT INTO public.\"ProductList\"(\"product_name\",\"In_box_count\",\"supplyer\",\"company\",\"price\",\"count_sys\",\"bar_code\",\"last_suplyed\")") +
                                              QString(" VALUES('%1',%2,'%3','%4',%5,%6,'%7',8)")
                                              .arg(strl[0]).arg(strl[1].toInt()).arg(strl[2]).arg(strl[3]).arg(strl[4].toDouble()).arg(strl[5].toInt()).arg(strl[6]).arg(strl[7]));
        RepositoryU::SetRequest(QString("INSERT INTO public.\"ProductPlan\"(\"product\",\"bar-code\",\"count\") VALUES('%1','%2',0)").arg(strl[0]).arg(strl[6]));
    }
    else if(strl.size()==6)RepositoryU::SetRequest(QString("INSERT INTO public.\"ProductSaleFull\"(\"product_name\",\"market_Id\",\"purchase_Id\",\"product_count\",\"price\",\"date\")") +
                                                    QString(" VALUES('%1',%2,%3,%4,%5,%6)")
                                                   .arg(strl[0]).arg(strl[1].toInt()).arg(strl[2].toInt()).arg(strl[3].toInt()).arg(strl[4].toDouble()).arg(strl[5]));
    m_myModel->Refresh();
    return 1;
}

void ModelController::goNext()
{
    if(currentPageCount<maxPageCount){
        m_myModel->goNext();
        currentPageCount++;
        emit currentPageChanged();
        emit myModelChanged();
    }
}

void ModelController::goPrev()
{
    if(currentPageCount>0){
        m_myModel->goPrev();
        currentPageCount--;
        emit currentPageChanged();
        emit myModelChanged();
    }
}

void ModelController::toggleListType(){}

void ModelController::deleteItems(QString str,int isArhive)
{
    //INSERT INTO public."ProductList"("product_name","In_box_count","supplyer","company","price","count_sys","bar_code","last_suplyed") VALUES('Igor',1,'Igor1','irog3',2.5,(0/1),'',2.2019);
    //INSERT INTO public."ProductSaleFull"("product_name","market_Id","purchase_Id","product_count","price","date") VALUES('Igor',1,1,1,2.5,2.2019);
    QStringList strl = str.split('|');
    QStringList temps;
    for(int i=0;i<strl.size();i++){
        temps.append(strl[i]);
        strl.removeAll(strl[i]);
    }
    QString vars;
    for(int i=0;i<temps.size();i++){
        vars = temps[i];
        QSqlQuery tempq = RepositoryU::GetRequest(QString("Select product_name FROM public.\"ProductList\" WHERE id=%1").arg(vars.toInt()));
        tempq.next();
        QString name = tempq.record().value("product_name").toString();
        if(!isArhive){
            if(temps.size()==8){
                RepositoryU::SetRequest(QString("DELETE FROM public.\"ProductList\"") + QString(" WHERE id = %1").arg(vars.toInt()));
                RepositoryU::SetRequest(QString("DELETE FROM public.\"ProductSaleFull\"") + QString(" WHERE product_name = '%1'").arg(name));
                RepositoryU::SetRequest(QString("DELETE FROM public.\"ProductPlan\"") + QString(" WHERE product = '%1'").arg(name));
            }
            else if(strl.size()==6)RepositoryU::SetRequest(QString("DELETE FROM public.\"ProductSaleFull\"") + QString(" WHERE id = %1").arg(vars.toInt()));
        }else{
            RepositoryU::SetRequest(QString("UPDATE public.\"ProductPlan\" SET count = 0 WHERE product='%1'").arg(vars.toInt()));
        }
    }
    m_myModel->Refresh();
}

void ModelController::updatePlan(QString str, int x)
{
    RepositoryU::SetRequest(QString("UPDATE public.\"ProductPlan\" SET count = %1 WHERE \"bar-code\"='%2'").arg(x).arg(str));
    showFromPlan(3);
}

void ModelController::onDataChanged()
{
    emit myModelChanged();
}
//data setters
void ModelController::setMyModel(InformationListModel* myModel)
{
    if (m_myModel == myModel)
        return;
    m_myModel = myModel;
    emit myModelChanged();
}
void ModelController::setMyPlan(InformationListModel* myModel)
{
    if (m_myPlan == myModel)
        return;
    m_myPlan = myModel;
    emit myPlanChanged();
}
void ModelController::setList(QStringList list)
{
    Q_UNUSED(list);
    *m_list = RepositoryU::tables;
    m_list->removeAt(m_list->indexOf("Accounts"));
    emit listChanged();
}
void ModelController::setMaxPage(int max)
{
    maxPageCount = max;
    emit maxPageChanged();
}
void ModelController::setCurrentPage(int current)
{
    currentPageCount = current;
    emit currentPageChanged();
}
void ModelController::setcolName(QStringList strl)
{
    columnsNameL = strl;
    emit colNameChanged();
}


