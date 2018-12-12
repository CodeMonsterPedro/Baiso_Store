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
    TextRole = Qt::UserRole + 1,
    IconRole
    };


    InformationListModel(QObject *parent = nullptr);

    Q_INVOKABLE virtual int rowCount(const QModelIndex &parent = QModelIndex()) const;
    virtual QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const;
    virtual QModelIndex index(int row, int column,
                              const QModelIndex &parent) const;
    virtual int columnCount(const QModelIndex &parent) const;

    QHash<int, QByteArray> roleNames() const;

    QStringList listData;
    QStringList sourceList;
    void Showfrom(int source=0);
    void Refresh(QStringList temp);
    void GetTopTen();

private:

    QString GetCountSystem(int val);
};

#endif // INFORMATIONLISTMODEL_H
