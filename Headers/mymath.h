#ifndef MYMATH_H
#define MYMATH_H

#include <QObject>
#include <QQuickItem>
#include <math.h>
#include"../RepositoryU/repositoryu.h"

class MyMath : public QObject
{
    Q_OBJECT

    struct Mean{
        double xm;
        double ym;
        double xym;
        double xm2;
    };

    struct Dispersion{
        double xS;
        double yS;
    };

public:

    struct Regression{
        double a;
        double b;
    };

    explicit MyMath(QObject *parent = nullptr);

    static double getCorrelationCoef(QVector<double> curList, QVector<double> prevList);

    static Regression getLineRegression(QVector<double> curList, QVector<double> prevList);

    static Regression getRectRegression(QVector<double> curList, QVector<double> prevList);

    static Mean getMean(QVector<double>,QVector<double>);

    static Dispersion getDispersion(QVector<double>,QVector<double>,Mean);
signals:

public slots:
};

#endif // MYMATH_H
