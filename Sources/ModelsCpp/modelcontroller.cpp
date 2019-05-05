#include "../../Headers/Models/modelcontroller.h"

ModelController::ModelController(QObject *parent) : QObject(parent),m_myModel(new InformationListModel())
{
    PlanCheck();
    m_myModel = new InformationListModel();
    m_myPlan = new InformationListModel();
    bigSaleList = new InformationListModel();
    maxPageCount=currentPageCount=0;
    m_list = new QStringList;
    *m_list = RepositoryU::tables;
    m_list->pop_front();
    emit listChanged();
    //productColumns.append("");
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
QStringList ModelController::colName(){
    return columnsNameL;
}
QStringList ModelController::productColumnNames(){
    return productColumns;
}
InformationListModel* ModelController::bsList(){
    return bigSaleList;
}
void ModelController::PlanCheck()
{
    QSqlQuery tempq3 = RepositoryU::GetRequest(QString("SELECT DISTINCT \"market_Id\" FROM public.\"ProductSaleFull\""));
    QVector<int> marketArray;
    while(tempq3.next()){
        marketArray.append(tempq3.record().value(tempq3.record().indexOf("market_Id")).toInt());
    }
    QSqlQuery tempq = RepositoryU::GetRequest(QString("SELECT bar_code, product_name FROM public.\"ProductList\""));
    QStringList strl;
    for(int i=0;i<marketArray.size();i++){
        QSqlQuery tempq2 = RepositoryU::GetRequest(QString("SELECT \"bar-code\" FROM public.\"ProductPlan\" WHERE market_id = %1").arg(marketArray[i]));
        strl.clear();
        while (tempq2.next()) {
            strl.append(tempq2.record().value(tempq2.record().indexOf("bar-code")).toString());
        }
        while (tempq.next()) {
            if(strl.contains(tempq.record().value(tempq.record().indexOf("bar_code")).toString()))continue;
            else {
                RepositoryU::SetRequest(QString("INSERT INTO public.\"ProductPlan\"(\"product\",\"bar-code\",\"count\",\"difference\",\"market_id\") VALUES('%1','%2',0,0,%3)")
                                        .arg(tempq.record().value(tempq.record().indexOf("product_name")).toString())
                                        .arg(tempq.record().value(tempq.record().indexOf("bar_code")).toString())
                                        .arg(marketArray[i]));
            }
        }
        tempq.seek(-1);
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

void ModelController::showFromPlan(int source, QString str)
{
    m_myPlan->market_id = str.toInt();
    m_myPlan->showfromPlan(str.toInt());
    setMyPlan(m_myPlan);
    setMaxPage(m_myPlan->maxPage);
    setCurrentPage(1);
}

int ModelController::addNewProductToRep(QString str)
{
    //INSERT INTO public."ProductList"("product_name","In_box_count","supplyer","company","price","count_sys","bar_code","last_suplyed") VALUES('Igor',1,'Igor1','irog3',2.5,(0/1),'',2.2019);
    QStringList strl = str.split('|');
    QDate date = QDate::currentDate();
    QString dateStr = "" + QString::number(date.day()) + "." + QString::number(date.month()) + "." + QString::number(date.year());
    RepositoryU::SetRequest(QString("INSERT INTO public.\"ProductList\"(\"product_name\",\"in_box_count\",\"supplyer\",\"company\",\"price\",\"count_sys\",\"bar_code\",\"last_suplyed\")") +
                                              QString(" VALUES('%1',%2,'%3','%4',%5,%6,'%7','%8')")
                                              .arg(strl[0]).arg(strl[1].toInt()).arg(strl[2]).arg(strl[3]).arg(strl[4].toDouble()).arg(strl[5].toInt()).arg(strl[6]).arg(dateStr));
    RepositoryU::SetRequest(QString("INSERT INTO public.\"ProductPlan\"(\"product\",\"bar-code\",\"count\") VALUES('%1','%2',0)").arg(strl[0]).arg(strl[6]));
    m_myModel->Refresh();
    return 1;
}

int ModelController::addNewPurchaseToRep(QString str)
{
    //INSERT INTO public."ProductSaleFull"("product_name","market_Id","purchase_Id","product_count","price","date") VALUES('Igor',1,1,1,2.5,2.2019);
    QStringList strl = str.split('|');
    RepositoryU::SetRequest(QString("INSERT INTO public.\"ProductSaleFull\"(\"product_name\",\"market_Id\",\"purchase_Id\",\"product_count\",\"price\",\"date\")") +
                                                        QString(" VALUES('%1',%2,%3,%4,%5,%6)")
                                                       .arg(strl[0]).arg(strl[1].toInt()).arg(strl[2].toInt()).arg(strl[3].toInt()).arg(strl[4].toDouble()).arg(strl[5]));
    m_myModel->Refresh();
    return 1;
}

int ModelController::addNewFullPurchaseToRep(QString str2, QStringList strl)
{
    QSqlQuery tempq = RepositoryU::GetRequest(QString("Select max(purchase_id) from public.\"ProductSaleFull\""));
    tempq.next();
    int newPurchaseN = tempq.record().value(tempq.record().indexOf("purchase_id")).toInt();
    QDate date = QDate::currentDate();
    QString dateStr = "" +QString::number(date.year()) + "-" + QString::number(date.month()) + "-" + QString::number(date.day());
    for(int i=0;i<strl.size();i++){
        QStringList strl2 = strl[i].split(' ');
        RepositoryU::SetRequest(QString("INSERT INTO public.\"ProductSaleFull\"(\"product_name\",\"market_Id\",\"purchase_Id\",\"product_count\",\"price\",\"date\")") +
                                                            QString(" VALUES('%1',%2,%3,%4,%5,%6)")
                                                            .arg(strl2[0]).arg(myStore).arg(newPurchaseN)
                                                            .arg(strl2[1].toInt()).arg(strl2[2].toDouble()).arg(dateStr));
    }
    return 0;
}

int ModelController::addNewAccountToRep(QString str)
{
    QSqlQuery tempq = RepositoryU::GetRequest(QString("SELECT max(id) from "));
    tempq.next();
    QStringList strl = str.split('|');
    int newId = tempq.record().value(tempq.record().indexOf("id")).toInt();
    RepositoryU::SetRequest(QString("INSERT INTO public.\"Accounts\"(\"id\",\"name\",\"role\",\"password\",\"login\",\"store\")") +
                            QString(" VALUES(%1,'%2','%3','%4','%5',%6)")
                            .arg(newId).arg(strl[0]).arg(strl[1]).arg(strl[2]).arg(strl[3]).arg(strl[4]).arg(strl[5].toInt()));
    return 0;
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

void ModelController::setMyStore(int x){
    myStore = x;
}

void ModelController::deleteItems(QString str,int isArhive, QString table)
{
    //INSERT INTO public."ProductList"("product_name","In_box_count","supplyer","company","price","count_sys","bar_code","last_suplyed") VALUES('Igor',1,'Igor1','irog3',2.5,(0/1),'',2.2019);
    //INSERT INTO public."ProductSaleFull"("product_name","market_Id","purchase_Id","product_count","price","date") VALUES('Igor',1,1,1,2.5,2.2019);
    QStringList strl = str.split('|');
    strl.removeLast();
    QStringList temps;
    for(int i=0;i<strl.size();i++){
        if(temps.contains(strl[i]))continue;
        else {
           temps.append(strl[i]);
        }
    }
    QString vars;
    for(int i=0;i<temps.size();i++){
        vars = temps[i];
        QSqlQuery tempq = RepositoryU::GetRequest(QString("Select product_name FROM public.\"ProductList\" WHERE id=%1").arg(vars.toInt()));
        tempq.next();
        QString name = tempq.record().value("product_name").toString();
        if(!isArhive){
            if(table=="Product"){
                RepositoryU::SetRequest(QString("DELETE FROM public.\"ProductList\"") + QString(" WHERE id = %1").arg(vars.toInt()));
                RepositoryU::SetRequest(QString("DELETE FROM public.\"ProductSaleFull\"") + QString(" WHERE product_name = '%1'").arg(name));
                RepositoryU::SetRequest(QString("DELETE FROM public.\"ProductPlan\"") + QString(" WHERE product = '%1'").arg(name));
            }
            else if(table=="Sale")RepositoryU::SetRequest(QString("DELETE FROM public.\"ProductSaleFull\"") + QString(" WHERE id = %1").arg(vars.toInt()));
        }else{
            RepositoryU::SetRequest(QString("UPDATE public.\"ProductPlan\" SET count = 0 WHERE product='%1'").arg(vars.toInt()));
        }
    }
    m_myModel->Refresh();
}

void ModelController::updatePlan(QString str, int x, QString y){
    QSqlQuery tempq = RepositoryU::GetRequest(QString("SELECT count, difference FROM public.\"ProductPlan\" WHERE \"bar-code\"='%1' AND market_id = %2").arg(str).arg(y.toInt()));
    tempq.next();
    int oldCount = tempq.record().value(tempq.record().indexOf("count")).toInt();
    int oldDifference = tempq.record().value(tempq.record().indexOf("difference")).toInt();
    int newDifference = (oldCount + oldDifference) - x;
    RepositoryU::SetRequest(QString("UPDATE public.\"ProductPlan\" SET count = %1, difference = %4 WHERE \"bar-code\"='%2' AND market_id = %3").arg(x).arg(str).arg(y.toInt()).arg(newDifference));
    showFromPlan(2, "" + QString::number(m_myPlan->market_id));
}

void ModelController::updateProduct(QString bcode, QString data)
{
    QSqlQuery tempq = RepositoryU::GetRequest(QString("SELECT product_name FROM public.\"ProductList\" WHERE bar_code='%1'").arg(bcode));
    tempq.next();
    QString oldName = tempq.record().value(tempq.record().indexOf("product_name")).toString();
    QStringList strl = data.split('|');
    RepositoryU::SetRequest(QString("UPDATE public.\"ProductList\" SET product_name = '%1', in_box_count = %2 , supplyer = '%3' , company = '%4' , price = %5 , count_sys = %6 WHERE bar_code='%7'")
                            .arg(strl[0]).arg(strl[1].toInt()).arg(strl[2]).arg(strl[3]).arg(strl[4].toDouble()).arg(strl[5].toInt()).arg(bcode));
    RepositoryU::SetRequest(QString("UPDATE public.\"ProductSaleFull\" SET product_name = '%1' WHERE product_name = '%2'").arg(strl[0]).arg(oldName));
    RepositoryU::SetRequest(QString("UPDATE public.\"ProductPlan\" SET product = '%1' WHERE product = '%2'").arg(strl[0]).arg(oldName));
    showFrom(0);
}

void ModelController::updateFullPurchase(QString ss, QStringList strl)
{
//    QSqlQuery tempq = RepositoryU::GetRequest(QString("Select max(purchase_id) from public.\"ProductSaleFull\""));
//    tempq.next();
//    int newPurchaseN = tempq.record().value(tempq.record().indexOf("purchase_id")).toInt();
//    QDate date = QDate::currentDate();
//    QString dateStr = "" +QString::number(date.year()) + "-" + QString::number(date.month()) + "-" + QString::number(date.day());
//    for(int i=0;i<strl.size();i++){
//        QStringList strl2 = strl[i].split(' ');
//        RepositoryU::SetRequest(QString("INSERT INTO public.\"ProductSaleFull\"(\"product_name\",\"market_Id\",\"purchase_Id\",\"product_count\",\"price\",\"date\")") +
//                                                            QString(" VALUES('%1',%2,%3,%4,%5,%6)")
//                                                            .arg(strl2[0]).arg(myStore).arg(newPurchaseN)
//                                                            .arg(strl2[1].toInt()).arg(strl2[2].toDouble()).arg(dateStr));
//    }


}
void ModelController::onDataChanged(){
    emit myModelChanged();
}
//data setters
void ModelController::setMyModel(InformationListModel* myModel){
    if (m_myModel == myModel)
        return;
    m_myModel = myModel;
    emit myModelChanged();
}
void ModelController::setMyPlan(InformationListModel* myModel){
    if (m_myPlan == myModel)
        return;
    m_myPlan = myModel;
    emit myPlanChanged();
}
void ModelController::setList(QStringList list){
    Q_UNUSED(list);
    *m_list = RepositoryU::tables;
    m_list->removeAt(m_list->indexOf("Accounts"));
    emit listChanged();
}
void ModelController::setMaxPage(int max){
    maxPageCount = max;
    emit maxPageChanged();
}
void ModelController::setCurrentPage(int current){
    currentPageCount = current;
    emit currentPageChanged();
}
void ModelController::setcolName(QStringList strl){
    columnsNameL = strl;
    emit colNameChanged();
}
void ModelController::setProductColumnNames(QStringList strl){
    productColumns = strl;
    emit productColumnNamesChanged();
}
void ModelController::setbsList(InformationListModel* list){
    bigSaleList = list;
    emit bsListChanged();
}


