#include "Headers/mymath.h"

MyMath::MyMath(QObject *parent) : QObject(parent){}

double MyMath::getCorrelationCoef(QVector<double> curList, QVector<double> prevList)
{
    double coef=0;//start, lists must have the same size
    //first, need to get a mean
    Mean M = getMean(curList,prevList);
    //now i get a mean, next need to find dispersion
    Dispersion D = getDispersion(curList,prevList,M);
    //next step is to get a covariation value
    double coefCov = M.xym - (M.xm * M.ym);
    //last step is to get a line korrelation coef
    coef = (coefCov)/(D.xS*D.yS);
    //end
    return coef;

}

MyMath::Regression MyMath::getLineRegression(QVector<double> curList, QVector<double> prevList)
{
    //y=ax+b
    //Y=!y+a(x-!x)
    //a = ( (!x*y) - (!x*!y) ) / ((!x^2) - (!x)^2)
    Regression R;
    R.a=R.b=0;
    Mean M;
    M = getMean(curList, prevList);
    R.a = (M.xym - (M.xm*M.ym))/(M.xm2 - (M.xm*M.xm));
    R.b = ((M.xm2*M.ym) - (M.xm*M.xym))/(M.xm2-(M.xm*M.xm));
    return R;
}

MyMath::Regression MyMath::getRectRegression(QVector<double> curList, QVector<double> prevList)
{
    Regression R;
    R.a=R.b=0;


    return R;
}

MyMath::Mean MyMath::getMean(QVector<double> curList, QVector<double> prevList)
{
    Mean M;
    M.xm=M.ym=M.xym=M.xm2=0;
    for (int i = 0; i < curList.size(); i++) {
        M.xm+=curList[i];
        M.ym+=prevList[i];
        M.xym+=curList[i]*prevList[i];
        M.xm2+=curList[i]*curList[i];
    }
    M.xm = M.xm/curList.size();
    M.ym = M.ym/curList.size();
    M.xym = M.xym/curList.size();
    M.xm2 = M.xm2/curList.size();
    return M;
}

MyMath::Dispersion MyMath::getDispersion(QVector<double> curList, QVector<double> prevList, Mean M)
{
    Dispersion D;
    D.xS=D.yS=0;
    for(int i=0;i<curList.size();i++){
        D.xS+=curList[i]*curList[i];
        D.yS+=prevList[i]*prevList[i];
    }
    D.xS=(D.xS/curList.size())-(M.xm*M.xm);
    D.yS=(D.yS/curList.size())-(M.ym*M.ym);
    D.xS=sqrt(D.xS);
    D.yS=sqrt(D.yS);
    return D;
}
