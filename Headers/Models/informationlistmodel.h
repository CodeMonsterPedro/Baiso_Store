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
        DateRole = Qt::UserRole + 9
    };


    InformationListModel(QObject *parent = Q_NULLPTR);

    virtual int rowCount(const QModelIndex &parent = QModelIndex()) const;
    virtual QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const;
    virtual QModelIndex index(int row, int column, const QModelIndex &parent) const;
    virtual int columnCount(const QModelIndex &parent) const;

    QHash<int, QByteArray> roleNames() const;

    QList<QSqlRecord> listData;
    QStringList sourceList;
    int currentTable=0;
    QSqlQuery lastQuery;

    void showfrom(int source=0);

    QVariant getLikeProduct(const QModelIndex &index, int role = Qt::DisplayRole) const;
    QVariant getLikePurchase(const QModelIndex &index, int role = Qt::DisplayRole) const;
    QVariant getLikeAccounts(const QModelIndex &index, int role = Qt::DisplayRole) const;
    void goNext();
    void goPrev();

    void addElement(QString value);
    void delElementLast();
    void delElementAt(int index);
    void Refresh(QStringList temp);
    void GetTopTen();

private:

    QString GetCountSystem(int val);
};

#endif // INFORMATIONLISTMODEL_H
