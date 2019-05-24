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
    struct PlanElement{
        QString barCode;
        QString productName;
        int difference;
        QVector<double> result;
        QVector<double> current;
        QVector<double> previos;
    };
    QList<PlanElement> mainPlanList;
    int productId;
    QString productName;
    int storeId;
    QVector<int> selectedDate;
    QVector<double> result;
    QVector<double> current;
    QVector<double> previos;
    int newPlannedCount;
    double newCoefficient;
    int topMargin;
    QString tempResult;
    QVector<double> resultList;
    int days;

    //Q_PROPERTY(QStringList list READ list WRITE setList NOTIFY listChanged)
    Q_PROPERTY(QString strResult READ strResult WRITE setStrResult NOTIFY strResultChanged)
    Q_PROPERTY(QVector<double> rList READ rList WRITE setRList NOTIFY rListChanged)
    Q_PROPERTY(QVector<double> cList READ cList WRITE setCList NOTIFY cListChanged)
    Q_PROPERTY(QVector<double> pList READ pList WRITE setPList NOTIFY pListChanged)
    Q_PROPERTY(QString currentProduct READ cProd WRITE setCProd NOTIFY cProdChanged)
    Q_PROPERTY(int nPlnCnt READ nPlnCnt WRITE setnPlnCnt NOTIFY nPlnCntChanged)
    Q_PROPERTY(double newCoef READ nCef WRITE setnCef NOTIFY nCefChanged)
    Q_PROPERTY(int topValueMargin READ topValueMargin WRITE settopValueMargin NOTIFY topValueMarginChanged)
    Q_PROPERTY(int daysCount READ daysCount WRITE setDaysCount NOTIFY daysCountChanged)

    AnaliticItem();
    ~AnaliticItem();

    QString strResult(){return tempResult;}
    QVector<double> rList(){return resultList;}
    QVector<double> cList(){return current;}
    QVector<double> pList(){return previos;}
    QString cProd(){return productName;}
    int nPlnCnt(){return newPlannedCount;}
    double nCef(){return newCoefficient;}
    int topValueMargin(){return topMargin;}
    int daysCount(){return days;}

    //Q_PROPERTY
    //Q_INVOKABLE

    Q_INVOKABLE void startAnalize(QString prodInfo, QString date);
    Q_INVOKABLE void acceptRequest();
    Q_INVOKABLE void declineRequest();
    Q_INVOKABLE void updateValuesForIt(QString bcode);


signals:
    void algorithmEnded();
    void strResultChanged();
    void rListChanged();
    void cListChanged();
    void pListChanged();
    void cProdChanged();
    void nPlnCntChanged();
    void nCefChanged();
    void topValueMarginChanged();
    void daysCountChanged();

public slots:
    void setStrResult(QString str);
    void setRList(QVector<double> strl);
    void setCList(QVector<double> strl);
    void setPList(QVector<double> strl);
    void setCProd(QString str);
    void setnPlnCnt(int x);
    void setnCef(double d);
    void settopValueMargin(int x);
    void setDaysCount(int x);

private:
    void setCurrentProductInfo(QString prodInfo);
    QVector<int> setCurrentDate(QString date);//updates current date and returns previous period date
    QVector<double> getProductValues(QVector<int> date);// return current product sale values started from date
    QVector<double> getProductValuesFrom(QVector<int> date, QVector<int> dateEnd);
    double getCountUpdate();// return a difference between fortuned plan count and current
    void EndAnalizeStep();
    int GetTopMargin(QVector<double>,QVector<double>);

};

#endif // ANALITICITEM_H
