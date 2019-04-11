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
    QVector<double> current;
    QVector<double> previos;

    QString tempResult;
    QVector<double> resultList;

    //Q_PROPERTY(QStringList list READ list WRITE setList NOTIFY listChanged)
    Q_PROPERTY(QString strResult READ strResult WRITE setStrResult NOTIFY strResultChanged)
    Q_PROPERTY(QVector<double> rList READ rList WRITE setRList NOTIFY rListChanged)
    Q_PROPERTY(QVector<double> cList READ cList WRITE setCList NOTIFY cListChanged)
    Q_PROPERTY(QVector<double> pList READ pList WRITE setPList NOTIFY pListChanged)
    AnaliticItem();
    ~AnaliticItem();

    QString strResult(){return tempResult;}
    QVector<double> rList(){return resultList;}
    QVector<double> cList(){return current;}
    QVector<double> pList(){return previos;}

    //Q_PROPERTY
    //Q_INVOKABLE

    Q_INVOKABLE void startAnalize(QString prodInfo, QString date);


signals:
    void algorithmEnded();
    void strResultChanged();
    void rListChanged();
    void cListChanged();
    void pListChanged();

public slots:
    void setStrResult(QString str);
    void setRList(QVector<double> strl);
    void setCList(QVector<double> strl);
    void setPList(QVector<double> strl);

private:
    void setCurrentProductInfo(QString prodInfo);
    QVector<int> setCurrentDate(QString date);
    QVector<double> getProductValues(QVector<int> date);

};

#endif // ANALITICITEM_H
