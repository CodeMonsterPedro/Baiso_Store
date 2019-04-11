#include "Headers/analiticitem.h"

AnaliticItem::AnaliticItem()
{
    qDebug()<<"Lol it works in C++\n";
}

AnaliticItem::~AnaliticItem()
{

}

void AnaliticItem::setStrResult(QString str)
{
    tempResult = str;
    emit strResultChanged();
}

void AnaliticItem::setRList(QVector<double> strl)
{
    resultList = strl;
    emit rListChanged();
}

void AnaliticItem::setCList(QVector<double> strl)
{
    current = strl;
    emit cListChanged();
}

void AnaliticItem::setPList(QVector<double> strl)
{
    previos = strl;
    emit pListChanged();
}

void AnaliticItem::setCurrentProductInfo(QString prodInfo)
{
    qDebug()<<"info - " + prodInfo<<endl;
    QSqlQuery tempq;
    if(prodInfo.toInt()==0 && prodInfo.size()<6){
        tempq = RepositoryU::GetRequest(QString("SELECT id, product_name FROM public.\"ProductList\" WHERE id=" + prodInfo));
    }else {
        tempq = RepositoryU::GetRequest(QString("SELECT id, product_name FROM public.\"ProductList\" WHERE product_name=\'" + prodInfo
                                                  + "\' OR bar_code = \'" + prodInfo + "\'"));
    }
    tempq.next();
    QSqlRecord tempr = tempq.record();
    productId = tempq.value(tempr.indexOf("id")).toInt();
    productName = tempq.value(tempr.indexOf("product_name")).toString();
}

QVector<int> AnaliticItem::setCurrentDate(QString date)
{
    QStringList templ = date.split('.');
    selectedDate.append(templ[0].toInt());
    selectedDate.append(templ[1].toInt());

    QVector<int> prevDate;
    if(selectedDate[0]==1){
        prevDate.append(12);
        prevDate.append(selectedDate[1]-1);
    }else {
        prevDate.append(selectedDate[0]-1);
        prevDate.append(selectedDate[1]);
    }
    return prevDate;
}

void AnaliticItem::startAnalize(QString prodInfo, QString date)
{
    prodInfo = "Apples";
    date = "2.2019";
    setCurrentProductInfo(prodInfo);
    QVector<int> prevDate = setCurrentDate(date);
    QVector<double> curValues = getProductValues(selectedDate);
    QVector<double> prevValues = getProductValues(prevDate);
    double coef = MyMath::getCorrelationCoef(prevValues, curValues);
    // if coef equals or more then 0.8 use Line regressing, if it less use Rect Resression
    MyMath::Regression R;
    if(coef >= 0.8) R = MyMath::getLineRegression(prevValues,curValues);
    else R = MyMath::getLineRegression(prevValues,curValues);
    //else R = MyMath::getRectRegression(curValues,prevValues);
    for(int i=0;i<curValues.size();i++){
        result.append(floor((R.a*curValues[i])+R.b));
    }
    setRList(result);
    setCList(curValues);
    setPList(prevValues);
    emit algorithmEnded();
}

QVector<double> AnaliticItem::getProductValues(QVector<int> date)
{
    QSqlQuery tempq = RepositoryU::GetRequest(" SELECT product_count, price FROM public.\"ProductSaleFull\" WHERE product_name=\'" + productName
                                              + "\' AND date_part('month',date)="+ QString::number(date[0])
                                              + " AND date_part('year',date)=" + QString::number(date[1]));
    QSqlRecord tempr = tempq.record();
    QVector<double> resultValues;
    while(tempq.next()){
        tempr = tempq.record();
        resultValues.append(tempr.value(tempr.indexOf("product_count")).toDouble());
    }
    return resultValues;
}


