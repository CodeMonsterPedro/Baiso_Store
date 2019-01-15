#ifndef ANALITICITEM_H
#define ANALITICITEM_H

#include <QObject>
#include <QQuickItem>
#include"../RepositoryU/repositoryu.h"

class AnaliticItem : public QQuickItem
{
    Q_OBJECT
public:
    int productId;
    QStringList selectedDate;
    double result;

    AnaliticItem();
    ~AnaliticItem();
    //Q_PROPERTY
    //Q_INVOKABLE

    Q_INVOKABLE void startAnalize(QString prodInfo, QString date);


signals:
    void algorithmEnded();
public slots:

private:
    double getCorrelationCoef(QStringList curList, QStringList prevList);
    double getLineRegression(QStringList curList, QStringList prevList);
    double getRectRegression(QStringList curList, QStringList prevList);

};

#endif // ANALITICITEM_H
