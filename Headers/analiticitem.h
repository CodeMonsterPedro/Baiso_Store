#ifndef ANALITICITEM_H
#define ANALITICITEM_H

#include <QObject>
#include <QQuickItem>
#include <math.h>
#include"../RepositoryU/repositoryu.h"
#include "mymath.h"

class AnaliticItem : public QQuickItem
{
    Q_OBJECT
public:
    int productId;
    QString productName;
    QVector<int> selectedDate;
    QVector<double> result;


    QString tempResult;
    QStringList resultList;

    //Q_PROPERTY(QStringList list READ list WRITE setList NOTIFY listChanged)
    Q_PROPERTY(QString strResult READ strResult WRITE setStrResult NOTIFY strResultChanged)
    Q_PROPERTY(QStringList rList READ rList WRITE setRList NOTIFY rListChanged)

    AnaliticItem();
    ~AnaliticItem();

    QString strResult(){return tempResult;}
    QStringList rList(){return resultList;}

    //Q_PROPERTY
    //Q_INVOKABLE

    Q_INVOKABLE void startAnalize(QString prodInfo, QString date);


signals:
    void algorithmEnded();
    void strResultChanged();
    void rListChanged();
public slots:
    void setStrResult(QString str);
    void setRList(QStringList strl);

private:
    void setCurrentProductInfo(QString prodInfo);
    QVector<int> setCurrentDate(QString date);
    QVector<double> getProductValues(QVector<int> date);

};

#endif // ANALITICITEM_H
