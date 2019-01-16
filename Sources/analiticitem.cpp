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

void AnaliticItem::startAnalize(QString prodInfo, QString date)
{
    qDebug()<<"info - " + prodInfo<<" date - " + date<<endl;

    QStringList templ = date.split('.');
    selectedDate.append(templ[0].toInt());
    selectedDate.append(templ[1].toInt());

    QSqlQuery tempq = RepositoryU::GetRequest(" SELECT id, product_name FROM public.\"ProductList\" WHERE id=" + prodInfo + " OR product_name=" + prodInfo + " OR bar_code = " + prodInfo);
    QSqlRecord tempr = tempq.record();
    productId = tempq.value(tempr.indexOf("id")).toInt();
    productName = tempq.value(tempr.indexOf("product_name")).toString();

    qDebug()<<"prodId - " + QString::number(productId)<<endl;

    QVector<int> prevDate;
    if(selectedDate[0]==1){
        prevDate.append(12);
        prevDate.append(selectedDate[1]-1);
    }else {
        prevDate.append(selectedDate[0]-1);
        prevDate.append(selectedDate[1]);
    }

    QVector<double> curValues = getProductValues(selectedDate);
    QVector<double> prevValues = getProductValues(prevDate);

    double coef = getCorrelationCoef(curValues,prevValues);
    // some godlike feature
    //if(coef>=0.8)result = getLineRegression(curValues,prevValues);
    //else result = getRectRegression(curValues,prevValues);

    result = getLineRegression(curValues,prevValues);

    setStrResult("coef - " + QString::number(coef) + " a - " + QString::number(result[0]));

    emit algorithmEnded();

}

double AnaliticItem::getCorrelationCoef(QVector<double> curList, QVector<double> prevList)
{
    double coef=0;

    //start, list must have the same size
    //first, need to get a mean
    double xm=0;
    double ym=0;
    double xym=0;
    for (int i = 0; i < curList.size(); i++) {
        xm+=curList[i];
        ym+=prevList[i];
        xym+=curList[i]*prevList[i];
    }
    xm=xm/curList.size();
    ym=ym/curList.size();
    xym=xym/curList.size();
    qDebug()<<"xm - " + QString::number(xm) + " ym - " + QString::number(ym) + " xym - " + QString::number(xym)<<endl;
    //now i get a mean, next need to find dispersion

    double xS=0;
    double yS=0;

    for(int i=0;i<curList.size();i++){
        xS+=curList[i]*curList[i];
        yS+=prevList[i]*prevList[i];
    }

    xS=(xS/curList.size())*(xm*xm);
    yS=(yS/curList.size())*(ym*ym);

    xS=sqrt(xS);
    yS=sqrt(yS);

    qDebug()<<"xS - " + QString::number(xS) + " yS - " + QString::number(yS)<<endl;

    //next step is to get a covariation value

    double coefCov=xym - (xm*ym);

    qDebug()<<"coefCov - " + QString::number(coefCov)<<endl;
    //last step is to get a line korrelation coef

    coef = (coefCov)/(xS*yS);

    qDebug()<<"coef - " + QString::number(coef)<<endl;

    //end

    return coef;
}

QVector<double> AnaliticItem::getLineRegression(QVector<double> curList, QVector<double> prevList)
{
    //y=ax+b
    //b*n+a*S(x) = S(y)
    //b*S(x)+a*S(x*x) = S(y*x)
    //b=(S(y)-a*S(x))/n
    //a = (S(y*x)-b*S(x))/S(x*x)
    //a =

    //lol

    //Y=!y+a(x-!x)
    //a = ( (!x*y) - (!x*!y) ) / ((!x^2) - (!x)^2)

    double a=0;

    double xm=0;
    double xm2=0;
    double ym=0;
    double xym=0;
    for (int i = 0; i < curList.size(); i++) {
        xm+=curList[i];
        xm2+=curList[i]*curList[i];
        ym+=prevList[i];
        xym+=curList[i]*prevList[i];
    }
    xm=xm/curList.size();
    xm2=xm2/curList.size();
    ym=ym/curList.size();
    xym=xym/curList.size();

    qDebug()<<"xm - " + QString::number(xm) + " ym - " + QString::number(ym) + " xym - " + QString::number(xym) + " xm2 - " + QString::number(xm2)<<endl;

    a=(xym - (xm*ym))/(xm2 - (xm*xm));


    qDebug()<<"a - " + QString::number(a)<<endl;

    QVector<double> temp;
    temp.append(a);

    //need to add b implementation

    return temp;

}

QVector<double> AnaliticItem::getRectRegression(QVector<double> curList, QVector<double> prevList)
{

}

QVector<double> AnaliticItem::getProductValues(QVector<int> date)
{
    QSqlQuery tempq = RepositoryU::GetRequest(" SELECT product_count, price FROM public.\"ProductSaleFull\" WHERE product_name=" + productName + " AND Month(date)="+ QString::number(date[0]) + " AND Year(date)=" + QString::number(date[1]));
    QSqlRecord tempr = tempq.record();
    QVector<double> resultValues;

    while(tempq.next()){
        resultValues.append(tempq.value(tempr.indexOf("product_count")).toDouble() * tempq.value(tempr.indexOf("price")).toDouble());
    }
    return resultValues;
}


