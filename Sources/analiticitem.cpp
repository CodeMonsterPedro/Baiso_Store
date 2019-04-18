#include "Headers/analiticitem.h"

AnaliticItem::AnaliticItem(){}

AnaliticItem::~AnaliticItem(){}

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

void AnaliticItem::setCProd(QString str){
    productName = str;
    emit cProdChanged();
}

void AnaliticItem::setnPlnCnt(int x)
{
    newPlannedCount = x;
    emit nPlnCntChanged();
}

void AnaliticItem::setnCef(double d)
{
    newCoefficient = d;
    emit nCefChanged();
}

void AnaliticItem::settopValueMargin(int x)
{
    topMargin = x;
    emit topValueMarginChanged();
}

void AnaliticItem::setCurrentProductInfo(QString prodInfo)
{
    QSqlQuery tempq;
    if(prodInfo.toInt()==0 && prodInfo.size()<6){
        tempq = RepositoryU::GetRequest(QString("SELECT id, product_name FROM public.\"ProductList\" WHERE id=" + prodInfo));
    }else {
        tempq = RepositoryU::GetRequest(QString("SELECT id, product_name FROM public.\"ProductList\" WHERE product_name=\'" + prodInfo + "\' OR bar_code = \'" + prodInfo + "\'"));
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
        newPlannedCount+=floor((R.a*curValues[i])+R.b);
    }

    settopValueMargin(GetTopMargin(curValues,prevValues));
    setnPlnCnt(newPlannedCount);
    setnCef(getCountUpdate());
    setRList(result);
    setCList(curValues);
    setPList(prevValues);
    emit algorithmEnded();
}

void AnaliticItem::acceptRequest()
{
    QString str = QString("UPDATE public.\"ProductPlan\" SET count = %1 WHERE product='%2'").arg(newPlannedCount).arg(productName);
    RepositoryU::SetRequest(str);
    EndAnalizeStep();
}

void AnaliticItem::declineRequest()
{
    EndAnalizeStep();
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

double AnaliticItem::getCountUpdate()
{
    QSqlQuery tempq = RepositoryU::GetRequest("SELECT count FROM public.\"ProductPlan\" Where product=\'" + productName + "\'");
    tempq.next();
    QSqlRecord tempr = tempq.record();
    double d = tempr.value(tempr.indexOf("count")).toDouble();
    return floor(newPlannedCount-d);
}

void AnaliticItem::EndAnalizeStep()
{
    productId = 0;
    productName = "";
    selectedDate.clear();
    result.clear();
    current.clear();
    previos.clear();
    newPlannedCount = 0;
    newCoefficient = 0;
    tempResult = "";
    resultList.clear();
    emit strResultChanged();
    emit rListChanged();
    emit cListChanged();
    emit pListChanged();
    emit cProdChanged();
    emit nPlnCntChanged();
    emit nCefChanged();

}

int AnaliticItem::GetTopMargin(QVector<double> x,QVector<double> y)
{
    double m1 = 0;
    for(int i=0;i<result.size();i++){
        if(result.at(i)>m1)m1=result.at(i);
        if(x.at(i)>m1)m1=x.at(i);
        if(y.at(i)>m1)m1=y.at(i);
    }
    return static_cast<int>(ceil(m1));
}


