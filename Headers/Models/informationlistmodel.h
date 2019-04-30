#ifndef INFORMATIONLISTMODEL_H
#define INFORMATIONLISTMODEL_H
#include<QObject>
#include<QString>
#include<QStringList>
#include<QVector>
#include<QtAlgorithms>
#include <QAbstractListModel>
#include <QAbstractTableModel>
#include"../../RepositoryU/repositoryu.h"

class InformationListModel : public QAbstractListModel
{
    Q_OBJECT
public:
    enum Roles{
        NameRole = Qt::UserRole + 1,
        MainIdRole = Qt::UserRole + 2,
        MarketIdRole = Qt::UserRole + 3,
        PurchaseIdRole = Qt::UserRole + 4,
        InBoxCountRole = Qt::UserRole + 5,
        CountSystemRole = Qt::UserRole + 6,
        BarCodeRole = Qt::UserRole + 7,
        PriceRole = Qt::UserRole + 8,
        DateRole = Qt::UserRole + 9,
        SupplyerRole = Qt::UserRole + 10,
        ProductCountRole = Qt::UserRole + 11
    };

    struct BigSaleElement
    {
        int purchaseId;
        QString date;
        QStringList productNames;
        QList<int> productCount;
        QList<double> productPrice;
    };


    InformationListModel(QObject *parent = Q_NULLPTR);

    Q_INVOKABLE virtual int rowCount(const QModelIndex &parent = QModelIndex()) const;
    virtual QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const;
    QHash<int, QByteArray> roleNames() const;

    QList<QSqlRecord> listData;
    QList<BigSaleElement> bigSaleList;

    QStringList sourceList;
    int currentTable=0;
    QSqlQuery lastQuery;

    int maxPage, currentPage;
    QStringList columnsNames;

//main functional methods
    void showfrom(int source=1);
    void goNext();
    void goPrev();
    void Refresh();

    void addElement(QSqlRecord value);
    void delElementLast();
    void delElementAt(int index);
private:
//universality methods
    QVariant getLikeProduct(const QModelIndex &index, int role = Qt::DisplayRole) const;
    QVariant getLikePurchase(const QModelIndex &index, int role = Qt::DisplayRole) const;
    QVariant getLikeAccounts(const QModelIndex &index, int role = Qt::DisplayRole) const;
    QVariant getLikePlan(const QModelIndex &index, int role = Qt::DisplayRole) const;
    QVariant getLikeBigSale(const QModelIndex &index, int role = Qt::DisplayRole) const;

//support methods

    void GetTopTen();
    void cleanUp();
    void fillUpPage();
    void fillUpBigSale();
    QString GetCountSystem(int val);
    void UpdateMaxPage();

signals:
    void dataChanged();
};

#endif // INFORMATIONLISTMODEL_H
