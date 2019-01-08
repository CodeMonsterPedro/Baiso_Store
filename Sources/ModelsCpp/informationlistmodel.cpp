#include "../../Headers/Models/informationlistmodel.h"

InformationListModel::InformationListModel(QObject *parent) : QAbstractListModel(parent)
{
   sourceList = RepositoryU::tables;
    QStringList temp;
    lastQuery = RepositoryU::GetRequest(QString("SELECT * FROM public.\"%1\" ").arg(sourceList[0]));
    QSqlRecord record= lastQuery.record();
    for(int i=0;i<1000;i++){
        listData.append(lastQuery.record());
        lastQuery.next();
    }
    lastQuery.seek(0);
}

QHash<int, QByteArray> InformationListModel::roleNames() const
{
    QHash<int, QByteArray> roles = QAbstractListModel::roleNames();
    roles[NameRole] = "m_Name";
    roles[MainIdRole] = "m_MainId";
    roles[MarketIdRole] = "m_MarketId";
    roles[PurchaseIdRole] = "m_PurchId";
    roles[InBoxCountRole] = "m_InBoxCount";
    roles[CountSystemRole] = "m_CountSys";
    roles[BarCodeRole] = "m_BarCode";
    roles[PriceRole] = "m_Price";
    roles[DateRole] = "m_Date";
    return roles;
}

int InformationListModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return listData.size();
}

QVariant InformationListModel::data(const QModelIndex &index, int role) const
{
    switch (currentTable) {
    case 0:
        return getLikeProduct(index,role);
    case 1:
        return getLikePurchase(index,role);
    case 2:
        return getLikeAccounts(index,role);
    case 3:
        break;
    case 4:
        break;
    default:
        break;
    }
    return QVariant();
}

QModelIndex InformationListModel::index(int row, int column, const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return createIndex(row, column);
}

int InformationListModel::columnCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return 1;
}

void InformationListModel::GetTopTen()
{
    /*QSqlRecord record = RepositoryU::GetRequest("SELECT DISTINCT id, product_name FROM public.\"ProductSalseFull\" ");
    QSqlQuery query = RepositoryU::lastQuery;
    QVector<long long> idList;
    QStringList strl;
    while(query.next())
    {
        idList.append(query.value(record.indexOf("id")).toLongLong());
        strl.append(query.value(record.indexOf("product_name")).toString());
    }
    QVector<double> totalSumList;
    QVector<double> totalCountList;
    long i=0;
    while(idList.size()!=i)
    {
        record = RepositoryU::GetRequest("SELECT price, product_count FROM public.\"ProductSalseFull\" WHERE id=" + QString::number(idList.takeFirst()));
        query = RepositoryU::lastQuery;
        double priceSum=0;
        double countSum=0;
        while(query.next())
        {
            countSum+=(query.value(record.indexOf("product_count")).toDouble());
            priceSum+=(query.value(record.indexOf("product_name")).toDouble());
        }
        totalSumList.append(priceSum);
        totalCountList.append(countSum);

    }
    std::max_element(totalCountList.begin(),totalCountList.end());
    std::max_element(totalCountList.begin(),totalCountList.end());*/
}

QString InformationListModel::GetCountSystem(int val)
{
    QString str = "";
    switch(val){
        case 0:str = "kgs";break;
        case 1:str = "item";break;
        case 2:break;
    }
    return str;
}




void InformationListModel::showfrom(int source)
{
    currentTable = source;
    QString table=sourceList[source];
    lastQuery = RepositoryU::GetRequest(QString("SELECT * FROM public.\"%1\" ").arg(table));
    QSqlRecord record= lastQuery.record();

    beginInsertRows(QModelIndex(),0,999);
    for(int i=0;i<1000;i++){
        listData.append(lastQuery.record());
        lastQuery.next();
    }
    endInsertRows();

    lastQuery.seek(0);
}

QVariant InformationListModel::getLikeProduct(const QModelIndex &index, int role) const
{
    switch (currentTable) {
    case 0:
        return getLikeProduct(index,role);
    case 1:
        return getLikePurchase(index,role);
    case 2:
        return getLikeAccounts(index,role);
    case 3:
        break;
    case 4:
        break;
    default:
        break;
    }
    return QVariant();
}

QVariant InformationListModel::getLikePurchase(const QModelIndex &index, int role) const
{
    switch (currentTable) {
    case 0:
        return getLikeProduct(index,role);
    case 1:
        return getLikePurchase(index,role);
    case 2:
        return getLikeAccounts(index,role);
    case 3:
        break;
    case 4:
        break;
    default:
        break;
    }
    return QVariant();
}

QVariant InformationListModel::getLikeAccounts(const QModelIndex &index, int role) const
{
    switch (currentTable) {
    case 0:
        return getLikeProduct(index,role);
    case 1:
        return getLikePurchase(index,role);
    case 2:
        return getLikeAccounts(index,role);
    case 3:
        break;
    case 4:
        break;
    default:
        break;
    }
    return QVariant();
}

void InformationListModel::goNext()
{

}

void InformationListModel::goPrev()
{

}

void InformationListModel::addElement(QString value)
{
    beginInsertRows(QModelIndex(), listData.size(), listData.size());
    endInsertRows();
}

void InformationListModel::delElementLast()
{
    if(listData.isEmpty())
    {
        return;
    }
    beginRemoveRows(QModelIndex(),listData.indexOf(listData.last()),listData.indexOf(listData.last()));
    listData.removeLast();
    endRemoveRows();
}

void InformationListModel::Refresh(QStringList temp)
{
    Q_UNUSED(temp);
    beginRemoveRows(QModelIndex(),0, listData.size());
    listData.clear();
    endRemoveRows();

    beginInsertRows(QModelIndex(),0,999);
    for(int i=0;i<1000;i++){
        listData.append(lastQuery.record());
        lastQuery.next();
    }
    endInsertRows();

}









