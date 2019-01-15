#include "Headers/analiticitem.h"

AnaliticItem::AnaliticItem()
{
    qDebug()<<"Lol it works in C++\n";
}

AnaliticItem::~AnaliticItem()
{

}

void AnaliticItem::startAnalize(QString prodInfo, QString date)
{
    qDebug()<<"info - " + prodInfo<<" date - " + date<<endl;

    selectedDate = date.split('.');
    QSqlQuery tempq = RepositoryU::GetRequest(" SELECT id FROM public.\"ProductList\" WHERE id=" + prodInfo + " OR product_name=" + prodInfo + " OR bar_code = " + prodInfo);
    QSqlRecord tempr = tempq.record();
    productId = tempq.value(tempr.indexOf("id")).toInt();

    qDebug()<<"prodId - " + QString::number(productId)<<endl;

    tempq = RepositoryU::GetRequest("");
    QStringList curValues;
    QStringList prevValues;

    double coef = getCorrelationCoef(curValues,prevValues);
    if(coef>=0.8)result = getLineRegression(curValues,prevValues);
    else result = getRectRegression(curValues,prevValues);

    emit algorithmEnded();

}

double AnaliticItem::getCorrelationCoef(QStringList curList, QStringList prevList)
{
    double coef=0;

    return coef;
}

double AnaliticItem::getLineRegression(QStringList curList, QStringList prevList)
{

}

double AnaliticItem::getRectRegression(QStringList curList, QStringList prevList)
{

}


