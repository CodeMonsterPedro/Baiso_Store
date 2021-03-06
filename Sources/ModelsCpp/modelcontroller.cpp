﻿#include "../../Headers/Models/modelcontroller.h"

ModelController::ModelController(QObject *parent) : QObject(parent),m_myModel(new InformationListModel())
{
    QSqlQuery tempq = RepositoryU::GetRequest(QString("Select DISTINCT product_name from public.\"ProductList\""));tempq.first();
    for(int i=0;i<tempq.size();i++){
         products.append(tempq.record().value(tempq.record().indexOf("product_name")).toString());
         tempq.next();
    }
    searchProduct = products_const = products;
    tempq = RepositoryU::GetRequest(QString("Select DISTINCT bar_code from public.\"ProductList\""));tempq.first();
        for(int i=0;i<tempq.size();i++){
             searchBarCode.append(tempq.record().value(tempq.record().indexOf("bar_code")).toString());
             tempq.next();
        }
    PlanCheck();
    //DataGenerator();
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
QStringList ModelController::productNames(){
    return products;
}
InformationListModel* ModelController::bsList(){
    return bigSaleList;
}
QStringList ModelController::bigSaleProducts(){
    return bsProducts;
}
QStringList ModelController::bigSaleCount(){
    return bsCount;
}
QStringList ModelController::bigSalePrice(){
    return bsPrice;
}
QStringList ModelController::productSearch(){
    return searchProduct;
}
QString ModelController::searchString(){
    return inputString;
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

void ModelController::DataGenerator()
{
    int diap = 45;
    int daipp = 400;
    int marketsCount=5;
    int purchaseCount = 500;
    QSqlQuery prodq = RepositoryU::GetRequest(QString("Select * from public.\"ProductList\""));prodq.first();
    int marketId = 0;
    unsigned long purchse = 1;
    while(marketId<marketsCount){

        for(int j=0;j<prodq.size();j++){
            QSqlRecord product = prodq.record();
            QDate date = QDate::currentDate();
            for(int i=0;i<purchaseCount;i++){
                RepositoryU::SetRequest(QString("INSERT INTO public.\"ProductSaleFull\"(\"product_name\",\"market_Id\",\"purchase_id\",\"product_count\",\"price\",\"date\")") +
                                        QString(" VALUES('%1',%2,%3,%4,%5,'%6'::date)")
                                        .arg(product.value(product.indexOf("product_name")).toString())
                                        .arg(marketId)
                                        .arg(purchse + i)
                                        .arg((rand()%diap)+daipp)
                                        .arg(product.value(product.indexOf("price")).toDouble())
                                        .arg("" + QString::number(date.year()) + "-" + QString::number(date.month()) + "-" + QString::number(date.day())));
            date = date.addDays(-1);
            }
            prodq.next();
        }purchse += purchaseCount;
        prodq.first();
        marketId++;
    }


}
//main functions
void ModelController::showFrom(int source)
{
    m_myModel->market_id = myStore;
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
    RepositoryU::SetRequest(QString("INSERT INTO public.\"ProductPlan\"(\"product\",\"bar-code\",\"count\",\"difference\",\"market_id\",\"current_count\") VALUES('%1','%2',0,0,1,0)").arg(strl[0]).arg(strl[6]));
    m_myModel->Refresh();
    return 1;
}

int ModelController::addNewPurchaseToRep(QString str)
{
    //INSERT INTO public."ProductSaleFull"("product_name","market_Id","purchase_Id","product_count","price","date") VALUES('Igor',1,1,1,2.5,2.2019);
    QStringList strl = str.split('|');
    RepositoryU::SetRequest(QString("INSERT INTO public.\"ProductSaleFull\"(\"product_name\",\"market_Id\",\"purchase_id\",\"product_count\",\"price\",\"date\")") +
                                                        QString(" VALUES('%1',%2,%3,%4,%5,%6)")
                                                       .arg(strl[0]).arg(strl[1].toInt()).arg(strl[2].toInt()).arg(strl[3].toInt()).arg(strl[4].toDouble()).arg(strl[5]));
    m_myModel->Refresh();
    return 1;
}

int ModelController::addNewFullPurchaseToRep(QString str2, QStringList strl)
{

    for(int i=0;i<strl.size();i++){
       QStringList strl2 = strl[i].split('|');
       QSqlQuery testq = RepositoryU::GetRequest(QString("SELECT * FROM public.\"ProductPlan\" where market_id=%1 AND product='%2'").arg(myStore).arg(strl2[0]));testq.first();
       if(testq.record().value(testq.record().indexOf("current_count")).toInt()<strl2[1].toInt())return 1;
    }

    QSqlQuery tempq = RepositoryU::GetRequest(QString("Select max(purchase_id) from public.\"ProductSaleFull\""));
    tempq.next();
    int newPurchaseN = tempq.record().value(tempq.record().indexOf("max")).toInt() + 1;
    QDate date = QDate::currentDate();
    QString dateStr = "" +QString::number(date.year()) + "-" + QString::number(date.month()) + "-" + QString::number(date.day());
    for(int i=0;i<strl.size();i++){
        QStringList strl2 = strl[i].split('|');
        QSqlQuery testq = RepositoryU::GetRequest(QString("SELECT * FROM public.\"ProductList\" Where product_name='%1'").arg(strl2[0]));testq.first();
        RepositoryU::SetRequest(QString("INSERT INTO public.\"ProductSaleFull\"(\"product_name\",\"market_Id\",\"purchase_id\",\"product_count\",\"price\",\"date\")") +
                                                            QString(" VALUES('%1',%2,%3,%4,%5,'%6')")
                                                            .arg(strl2[0]).arg(myStore).arg(newPurchaseN)
                                                            .arg(strl2[1].toInt()).arg(testq.record().value(testq.record().indexOf("price")).toDouble()).arg(dateStr));
        RepositoryU::SetRequest(QString("UPDATE public.\"ProductPlan\" SET current_count=%1 WHERE product='%2' AND market_id=%3")
                                                            .arg(strl2[1].toInt()).arg(strl2[0]).arg(myStore));
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
            else if(table=="Sale")RepositoryU::SetRequest(QString("DELETE FROM public.\"ProductSaleFull\"") + QString(" WHERE purchase_id = %1").arg(vars.toInt()));
        }else{
            RepositoryU::SetRequest(QString("UPDATE public.\"ProductPlan\" SET count = 0 WHERE product='%1'").arg(vars.toInt()));
        }
    }
    m_myModel->Refresh();
    emit myModelChanged();
}

void ModelController::updatePlan(QString str, int x, QString y){
    QSqlQuery tempq = RepositoryU::GetRequest(QString("SELECT count, difference FROM public.\"ProductPlan\" WHERE \"bar-code\"='%1' AND market_id = %2").arg(str).arg(y.toInt()));
    tempq.next();
    int newDifference = tempq.record().value(tempq.record().indexOf("difference")).toInt();
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
    QSqlQuery tempq = RepositoryU::GetRequest(QString("Select * from public.\"ProductSaleFull\" Where purchase_id=%1").arg(ss));
    QStringList currentProducts;
    QList<int> currentCounts;
    while(tempq.next()){
        QSqlRecord tempr = tempq.record();
        currentProducts.append(tempr.value(tempr.indexOf("product_name")).toString());
        currentCounts.append(tempr.value(tempr.indexOf("product_count")).toInt());
    }
    QStringList removeList = currentProducts;
    for(int i=0;i<currentProducts.size();i++){
        QStringList strl2 = strl[i].split('|');
        if(removeList.contains(strl2[0]))removeList.removeAt(currentProducts.indexOf(strl2[0]));
    }
    for(int i=0;i<removeList.size();i++){
        RepositoryU::SetRequest(QString("DELETE FROM public.\"ProductSaleFull\" WHERE product_name = '%1' AND purchase_id=%2").arg(removeList[i]).arg(ss));
        currentProducts.removeAt(currentProducts.indexOf(removeList[i]));
        currentCounts.removeAt(currentProducts.indexOf(removeList[i]));
    }
    for (int i=0;i<currentProducts.size();i++) {
        QStringList strl2 = strl[i].split('|');
        RepositoryU::SetRequest(QString("UPDATE public.\"ProductSaleFull\" SET product_count = %1 WHERE product_name = '%2'").arg(strl[1]).arg(currentProducts[currentProducts.indexOf(strl2[0])]));
    }

}

void ModelController::printBigSale(int id)
{
    QSqlQuery tempq = RepositoryU::GetRequest(QString("SELECT * FROM public.\"ProductSaleFull\" WHERE purchase_id=%1").arg(id));
    tempq.next();
    QDate date = tempq.record().value(tempq.record().indexOf("date")).toDate();
    QString dateStr = "" + QString::number(date.day()) + "." + QString::number(date.month()) + "." + QString::number(date.year());
    QString html = QString("<h1> Расчетная квитаниция №%1 от %2</h1>").arg(id).arg(dateStr);
    html += "</br><table width=600px border=2 align=center><tr><td width=300><center>Продукт</center></td><td width=80><center>Кол-во</center></td><td width=100><center>Цена</center></td></tr>";
    for(int i=0;i<tempq.size();i++){
        QSqlRecord tempr = tempq.record();
        html+=QString("<tr><td> %1</td><td><center>%2</center></td><td><center>%3</center></td></tr>").arg(tempr.value(tempr.indexOf("product_name")).toString()).arg(tempr.value(tempr.indexOf("product_count")).toString()).arg(tempr.value(tempr.indexOf("price")).toString());
        tempq.next();
    }
    html+="</table>";
    QTextDocument document;
    document.setHtml(html);
    QPrinter printer(QPrinter::PrinterResolution);
    printer.setOutputFormat(QPrinter::PdfFormat);
    printer.setOutputFileName("decl.pdf");
    QPrintDialog printDialog(&printer);
    if (printDialog.exec() == QDialog::Accepted) {
        document.print(&printer);
    }

}

void ModelController::printPlan(int store)
{
    QSqlQuery tempq = RepositoryU::GetRequest(QString("SELECT * FROM public.\"ProductPlan\" WHERE market_id=%1").arg(store));tempq.next();
    QDate date = tempq.record().value(tempq.record().indexOf("date")).toDate();
    QString dateStr = "" + QString::number(date.day()) + "." + QString::number(date.month()) + "." + QString::number(date.year());
    QString html = QString("<h1> План закупок магазина №%1 </h1>").arg(store);
    html += "<br><table width=600px border=2><tr><td width=300><center>Продукт</center></td><td width=80><center>К закупке</center></td><td width=100><center>Цена закупки</center></td></tr>";

    QSqlQuery tempq2;
    QSqlRecord tempr;
    double fullPrice=0;
    for(int i=0;i<tempq.size();i++){
        tempr = tempq.record();
        tempq2  = RepositoryU::GetRequest(QString("Select price from public.\"ProductList\" Where bar_code='%1'").arg(tempr.value(tempr.indexOf("bar-code")).toString()));tempq2.first();
        double price = (tempq2.record().value(tempq2.record().indexOf("price")).toDouble()) *  tempr.value(tempr.indexOf("count")).toInt();
        fullPrice += price;
        html+=QString("<tr><td>%1</td><td><center>%2</center></td><td><center>%3</center></td></tr>")
                .arg(tempr.value(tempr.indexOf("product")).toString())
                .arg(tempr.value(tempr.indexOf("count")).toString())
                .arg(price);
        tempq.next();
    }
    html += QString("<tr><td colspan=3> Общая стоимость закупки: %1</td></tr>").arg(fullPrice);
    html += QString("<tr><td colspan=3> ПДВ 18%: %1</td></tr>").arg(fullPrice * 1.18);
    html += "</table>";
    QTextDocument document;
    document.setHtml(html);
    QPrinter printer(QPrinter::PrinterResolution);
    printer.setOutputFormat(QPrinter::PdfFormat);
    printer.setOutputFileName("decl.pdf");
    QPrintDialog printDialog(&printer);
    if (printDialog.exec() == QDialog::Accepted) {
        document.print(&printer);
    }

}

void ModelController::useProduct(QString str)
{
    products.removeAt(products.indexOf(str));
    searchBarCode.removeAt(products.indexOf(str));
    emit productNamesChanged();
}

void ModelController::refreshProducts()
{
    products = products_const;
    resetBarCodeSearch();
    emit productNamesChanged();
}

bool ModelController::isCorrectCount(QString str, int count)
{
    QSqlQuery tempq = RepositoryU::GetRequest(QString("SELECT * FROM public.\"ProductPlan\" Where product='%1' AND market_id=%2").arg(str).arg(myStore));
    tempq.first();QSqlRecord tempr = tempq.record();
    if(tempr.value(tempr.indexOf("current_count")).toInt()>=count)return true;
    else return false;
}

void ModelController::setCurrentBigSale(int id)
{
    QStringList product;
    QStringList count;
    QStringList price;
    QSqlQuery tempq = RepositoryU::GetRequest(QString("Select * from public.\"ProductSaleFull\" Where purchase_Id=%1").arg(id));
    while(tempq.next()){
        QSqlRecord tempr = tempq.record();
        product.append(tempr.value(tempr.indexOf("product_name")).toString());
        count.append(tempr.value(tempr.indexOf("product_count")).toString());
        price.append(tempr.value(tempr.indexOf("price")).toString());
    }
    setBigSaleProducts(product);
    setBigSaleCount(count);
    setBigSalePrice(price);
    emit currentBigSaleSetted();
}

int ModelController::getProductMaxValue(QString str)
{
    int maxCount = 0;
    QSqlQuery tempq = RepositoryU::GetRequest(QString("Select * from public.\"ProductPlan\" Where product='%1' AND market_id=%2").arg(str).arg(myStore));tempq.first();
    maxCount = tempq.record().value(tempq.record().indexOf("current_count")).toInt();
    return maxCount;
}

void ModelController::sortBy(int id)
{
    if(id<3)m_myModel->SortProduct(id);
    else if(id>=3)m_myModel->SortBigSale(id);
    emit myModelChanged();
}

void ModelController::search(QString str)
{
    bool isDigigt = false;
    str.toLong(&isDigigt,10);
    for(int i=0;i<searchProduct.size();i++){
        if(searchProduct[i].size()<str.size() && !isDigigt){
            searchProduct.removeAt(i);i--;
        }
        if(searchBarCode[i].size()<str.size() && isDigigt){
            searchBarCode.removeAt(i);
            searchProduct.removeAt(i);
            i--;
        }
    }
    bool flag = false;
    for(int i=0;i<searchProduct.size();i++){
        flag = false;
        if(isDigigt){
            for(int j=0;j<str.size();j++){
                if(str[j] != searchBarCode[i][j]){flag = true;break;}
            }
        }
        else {
            for(int j=0;j<str.size();j++){
                if(str[j] != searchProduct[i][j]){flag = true;break;}
            }
        }
        if(flag){
            searchBarCode.removeAt(i);
            searchProduct.removeAt(i);
            i--;
        }
    }
    setSearchString(str);
    setProductSearch(searchProduct);
}

void ModelController::resetProductSearch()
{
    setProductSearch(products_const);
}

void ModelController::resetBarCodeSearch()
{
    searchBarCode.clear();
    QSqlQuery tempq = RepositoryU::GetRequest(QString("Select DISTINCT bar_code from public.\"ProductList\""));tempq.first();
        for(int i=0;i<tempq.size();i++){
             searchBarCode.append(tempq.record().value(tempq.record().indexOf("bar_code")).toString());
             tempq.next();
        }
}

void ModelController::searchPlan(QString str)
{
    if(!m_myPlan->saved){
        m_myPlan->reservListDate = m_myPlan->listData;
        m_myPlan->saved = true;
    }
    for(int i=0;i<m_myPlan->listData.size();i++){
        QSqlRecord temp = m_myPlan->listData[i];
        if((temp.value(temp.indexOf("product")).toString()).size()<str.size()){
            m_myPlan->delElementAt(i);i--;
        }
    }
    bool flag = false;
    for(int i=0;i<m_myPlan->listData.size();i++){
        flag = false;
        QSqlRecord temp = m_myPlan->listData[i];
        QString temps = temp.value(temp.indexOf("product")).toString();
            for(int j=0;j<str.size();j++){
                if(str[j] != temps[j]){flag = true;break;}
            }
        if(flag){
            m_myPlan->delElementAt(i);
            i--;
        }
    }
    setSearchString(str);
    setMyPlan(m_myPlan);
    emit myPlanChanged();
}

void ModelController::searchBigSale(QString str)
{

}

void ModelController::searchProducts(QString str)
{
    bool isDigigt = false;
    str.toLong(&isDigigt,10);

    if(!m_myModel->saved){
        m_myModel->reservListDate = m_myModel->listData;
        m_myModel->saved = true;
    }
    for(int i=0;i<m_myModel->listData.size();i++){
        QSqlRecord temp = m_myModel->listData[i];
        if((temp.value(temp.indexOf("product_name")).toString()).size()<str.size() && !isDigigt){
            m_myModel->delElementAt(i);i--;
        }
        if((temp.value(temp.indexOf("bar_code")).toString()).size()<str.size() && isDigigt){
            m_myModel->delElementAt(i);i--;
        }
    }
    bool flag = false;
    for(int i=0;i<m_myModel->listData.size();i++){
        flag = false;
        QSqlRecord temp = m_myModel->listData[i];
        QString temps;

        if(isDigigt) temps = temp.value(temp.indexOf("bar_code")).toString();
        else temps = temp.value(temp.indexOf("product_name")).toString();
            for(int j=0;j<str.size();j++){
                if(str[j] != temps[j]){flag = true;break;}
            }
        if(flag){
            m_myModel->delElementAt(i);
            i--;
        }
    }
    setSearchString(str);
    setMyModel(m_myModel);
    emit myModelChanged();
}

void ModelController::searchReset()
{
    showFrom(0);
    showFromPlan(2, "" + QString::number(m_myPlan->market_id));
}

void ModelController::acceptAll(QString y)
{
    QSqlQuery tempq = RepositoryU::GetRequest(QString("SELECT * FROM public.\"ProductPlan\" WHERE market_id = %1").arg(y));
    while(tempq.next()){
    QSqlRecord temp = tempq.record();
    RepositoryU::SetRequest(QString("UPDATE public.\"ProductPlan\" SET count = %1 WHERE \"bar-code\"='%2' AND market_id = %3")
                            .arg(temp.value(temp.indexOf("difference")).toString())
                            .arg(temp.value(temp.indexOf("bar-code")).toString())
                            .arg(y.toInt()));
    }
    showFromPlan(2, "" + QString::number(m_myPlan->market_id));
}

void ModelController::acceptIt(QString str, int x, QString y)
{
    QSqlQuery tempq = RepositoryU::GetRequest(QString("SELECT count, difference FROM public.\"ProductPlan\" WHERE \"bar-code\"='%1' AND market_id = %2").arg(str).arg(y.toInt()));
    tempq.next();
    int newDifference = tempq.record().value(tempq.record().indexOf("difference")).toInt();
    RepositoryU::SetRequest(QString("UPDATE public.\"ProductPlan\" SET count = %1, difference = %4 WHERE \"bar-code\"='%2' AND market_id = %3").arg(newDifference).arg(str).arg(y.toInt()).arg(newDifference));
    showFromPlan(2, "" + QString::number(m_myPlan->market_id));
}

void ModelController::dateFilter(QString date1, QString date2, int x)
{
    QStringList date3 = date1.split('.');
    QStringList date4 = date2.split('.');
    QDate startDate = QDate(date3[2].toInt(),date3[1].toInt(),date3[0].toInt());
    QDate endDate = QDate(date4[2].toInt(),date4[1].toInt(),date4[0].toInt());
    if(x==0){
        for(int i=0;i<m_myModel->listData.size();i++){
            QDate date5 = QDate(m_myModel->listData[i].value(m_myModel->listData[i].indexOf("date")).toDate());
            QDate elementDate = QDate(date5.year(),date5.month(),date5.day());
            if(elementDate<startDate || elementDate>endDate){ m_myModel->delElementAt(i);i--;}
        }
    }else if(x==1){
        for(int i=0;i<m_myModel->bigSaleList.size();i++){
            QDate elementDate = QDate(m_myModel->bigSaleList[i].date);
            if(elementDate<startDate || elementDate>endDate){ m_myModel->delElementAtBigSale(i);i--;}
        }
    }
    emit myModelChanged();
    emit bsListChanged();
}
void ModelController::onDataChanged(){
    emit myModelChanged();
    emit bsListChanged();
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
void ModelController::setProductNames(QStringList strl){
    products = strl;
    emit productNamesChanged();
}
void ModelController::setBigSaleProducts(QStringList strl){
    bsProducts = strl;
    emit bigSaleProductsChanged();
}
void ModelController::setBigSaleCount(QStringList strl){
    bsCount = strl;
    emit bigSaleCountChanged();
}
void ModelController::setBigSalePrice(QStringList strl){
    bsPrice = strl;
    emit bigSalePriceChanged();
}
void ModelController::setProductSearch(QStringList strl){
    searchProduct = strl;
    emit productSearchChanged();
}
void ModelController::setSearchString(QString str){
    inputString = str;
    emit searchStringChanged();
}


