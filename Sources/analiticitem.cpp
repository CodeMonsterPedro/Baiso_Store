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

void AnaliticItem::setDaysCount(int x)
{
    days = x;
    emit daysCountChanged();
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
    selectedDate.append(templ[2].toInt());
    QDate curTime = QDate::currentDate();
    QDate startTime = QDate(templ[2].toInt(),templ[1].toInt(),templ[0].toInt());
    setDaysCount(startTime.daysTo(curTime));
    QDate prevTime = startTime.addDays(-startTime.daysTo(curTime));
    QVector<int> prevDate;
    prevDate.append(prevTime.day());
    prevDate.append(prevTime.month());
    prevDate.append(prevTime.year());
    return prevDate;
}

void AnaliticItem::startAnalize(QString prodInfo, QString date)
{
    storeId = prodInfo.toInt();
    QSqlQuery tempq = RepositoryU::GetRequest(QString("SELECT distinct product_name FROM public.\"ProductSaleFull\" WHERE \"market_Id\"=%1").arg(prodInfo.toInt()));
    while(tempq.next()){
        result.clear();
        prodInfo = tempq.record().value(tempq.record().indexOf("product_name")).toString();
        PlanElement pe;
        pe.productName = prodInfo;
        setCurrentProductInfo(prodInfo);
        QVector<int> prevDate = setCurrentDate(date);
        QVector<double> curValues = getProductValues(selectedDate);
        QVector<double> prevValues = getProductValuesFrom(prevDate,selectedDate);
        //double coef = MyMath::getCorrelationCoef(prevValues, curValues);
        // if coef equals or more then 0.8 use Line regressing, if it less use Rect Resression
        MyMath::Regression R;
        //if(coef >= 0.8) R = MyMath::getLineRegression(prevValues,curValues);
        //else R = MyMath::getLineRegression(prevValues,curValues);
        R = MyMath::getLineRegression(prevValues,curValues);
        //else R = MyMath::getRectRegression(curValues,prevValues);

        for(int i=0;i<curValues.size();i++){
            result.append(floor((R.a*curValues[i])+R.b));
            newPlannedCount+=floor((R.a*curValues[i])+R.b);
        }
        pe.result = result;
        pe.current = curValues;
        pe.previos = prevValues;
        pe.difference = newPlannedCount;
        settopValueMargin(GetTopMargin(curValues,prevValues));
        setnPlnCnt(newPlannedCount);
        setnCef(getCountUpdate());
        setRList(result);
        setCList(curValues);
        setPList(prevValues);
        RepositoryU::SetRequest(QString("UPDATE public.\"ProductPlan\" SET difference = %1 WHERE product = '%2' AND \"market_id\"=%3").arg(newPlannedCount).arg(prodInfo).arg(storeId));
        emit algorithmEnded();
        mainPlanList.append(pe);
    }
}

void AnaliticItem::acceptRequest()
{
    QString str = QString("UPDATE public.\"ProductPlan\" SET count = %1 WHERE product='%2' AND \"market_id\"=%3").arg(newPlannedCount).arg(productName).arg(storeId);
    RepositoryU::SetRequest(str);
    EndAnalizeStep();
}

void AnaliticItem::declineRequest()
{
    EndAnalizeStep();
}

void AnaliticItem::updateValuesForIt(QString bcode)
{
    int i=0;
    if(mainPlanList.isEmpty())return;
    bool flag = false;
    for(int j=0;j<mainPlanList.size();j++)
        if(mainPlanList[j].barCode == bcode){
            i=j;
            flag = true;
        }
    if(!flag)return;
    settopValueMargin(GetTopMargin(mainPlanList[i].current,mainPlanList[i].previos));
    newPlannedCount = mainPlanList[i].difference;
    setnPlnCnt(newPlannedCount);
    setnCef(getCountUpdate());
    result = mainPlanList[i].result;
    setRList(result);
    setCList(mainPlanList[i].current);
    setPList(mainPlanList[i].previos);
}

QVector<double> AnaliticItem::getProductValues(QVector<int> date)
{
    QString dateStr = "" + QString::number(date[2]) + "-" + QString::number(date[1]) + "-" + QString::number(date[0]);
    QSqlQuery tempq = RepositoryU::GetRequest(QString("SELECT product_count, price FROM public.\"ProductSaleFull\" WHERE product_name='%1' AND \"market_Id\"=%3 AND date >= '%2'::date")
                                              .arg(productName).arg(dateStr).arg(storeId));
    QSqlRecord tempr = tempq.record();
    QVector<double> resultValues;
    while(tempq.next()){
        tempr = tempq.record();
        resultValues.append(tempr.value(tempr.indexOf("product_count")).toDouble());
    }
    return resultValues;
}

QVector<double> AnaliticItem::getProductValuesFrom(QVector<int> date, QVector<int> dateEnd)
{
    QString dateStr = "" + QString::number(date[2]) + "-" + QString::number(date[1]) + "-" + QString::number(date[0]);
    QString dateEndStr = "" + QString::number(dateEnd[2]) + "-" + QString::number(dateEnd[1]) + "-" + QString::number(dateEnd[0]);
    QSqlQuery tempq = RepositoryU::GetRequest(QString("SELECT product_count, price FROM public.\"ProductSaleFull\" WHERE product_name='%1' AND \"market_Id\"=%3 AND date >= '%2'::date AND date < '%4'::date")
                                              .arg(productName).arg(dateStr).arg(storeId).arg(dateEndStr));
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


