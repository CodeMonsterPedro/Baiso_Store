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

void AnaliticItem::setRList(QStringList strl)
{
    resultList = strl;
    emit rListChanged();
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
    qDebug()<<"info - " + prodInfo<<" date - " + date<<endl;
    prodInfo = "Apples";
    date = "2.2019";
    setCurrentProductInfo(prodInfo);


    QVector<int> prevDate = setCurrentDate(date);
    QVector<double> curValues = getProductValues(selectedDate);
    QVector<double> prevValues = getProductValues(prevDate);

    double coef = MyMath::getCorrelationCoef(curValues,prevValues);
    // if coef equals or more then 0.8 use Line regressing, if it less use Rect Resression
    if(coef>=0.8)result = MyMath::getLineRegression(curValues,prevValues);
    else result = MyMath::getRectRegression(curValues,prevValues);

    //result = MyMath::getLineRegression(curValues,prevValues);

    setStrResult("coef - " + QString::number(coef) + " a - " + QString::number(result[0]));

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


