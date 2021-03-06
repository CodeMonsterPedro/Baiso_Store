﻿#ifndef INFORMATIONLISTMODEL_H
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
        ProductCountRole = Qt::UserRole + 11,
        CompanyRole = Qt::UserRole + 12,
        DifferenceRole = Qt::UserRole + 13,
        BigSaleRowsCount = Qt::UserRole + 14
    };

    struct BigSaleElement
    {
        int purchaseId;
		int storeId;
        QDate date;
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
    QList<QSqlRecord> reservListDate;
    QList<BigSaleElement> reservBigSaleList;
    bool bsSaved = false;
    bool saved = false;

    QStringList sourceList;
    int currentTable=0;
    QSqlQuery lastQuery;
    int market_id;

    int maxPage, currentPage;
    QStringList columnsNames;

//main functional methods
    void showfrom(int source=1);
    void showfromPlan(int x);
    void goNext();
    void goPrev();
    void Refresh();
    void SortProduct(int id);
    void SortBigSale(int id);

    void addElement(QSqlRecord value);
    void delElementLast();
    void delElementAt(int index);
    void delElementAtBigSale(int index);
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
