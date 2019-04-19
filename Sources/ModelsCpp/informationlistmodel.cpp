#include "../../Headers/Models/informationlistmodel.h"

InformationListModel::InformationListModel(QObject *parent) : QAbstractListModel(parent)
{
   if(RepositoryU::isConnected)sourceList = RepositoryU::tables;
   sourceList.pop_front();//delete accounts from the list


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
    roles[SupplyerRole] = "m_Supplyer";
    qDebug()<<"roleNames\n";
    return roles;
}

int InformationListModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
            qDebug()<<"LIST DATA SIZE - " + QString::number(listData.size());
    return listData.size();
}

QVariant InformationListModel::data(const QModelIndex &index, int role) const
{
    switch (currentTable) {
    case 0:
        return getLikeAccounts(index,role);
    case 1:
        return getLikePurchase(index,role);
    case 2:
        return getLikeProduct(index,role);
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

void InformationListModel::showfrom(int source)
{
    this->cleanUp();
    currentTable = source;
    QString table=sourceList[source-1];
    lastQuery = RepositoryU::GetRequest(QString("SELECT * FROM public.\"%1\" ").arg(table));
   // lastQuery.
   // columnsNames;
    this->fillUpPage();
    this->UpdateMaxPage();

}

void InformationListModel::cleanUp()
{
    beginRemoveRows(QModelIndex(),0,0);
    listData.clear();
    endRemoveRows();
}

void InformationListModel::fillUpPage()
{
    beginInsertRows(QModelIndex(),0,(lastQuery.size()>1000? 999 : lastQuery.size()));
    for(int i=0;i<(lastQuery.size()>1000? 1000 : lastQuery.size()+1);i++){
        listData.append(lastQuery.record());
        lastQuery.next();
    }//work aroung
    listData.pop_front();
    endInsertRows();
}

void InformationListModel::UpdateMaxPage()
{
    currentPage = 1;
    maxPage = lastQuery.size()%1000==0? lastQuery.size()/1000 : (lastQuery.size()/1000) + 1;
}

QVariant InformationListModel::getLikeProduct(const QModelIndex &index, int role) const
{
    QSqlRecord temp = listData.at(index.row());
    switch (role) {
    case NameRole:
        return temp.value(temp.indexOf("product_name"));
    case MainIdRole:
        return temp.value(temp.indexOf("id"));
    case InBoxCountRole:
        return temp.value(temp.indexOf("in_box_count"));
    case CountSystemRole:
        return temp.value(temp.indexOf("count_sys")).toInt()? "item" : "kgs";
    case BarCodeRole:
        return temp.value(temp.indexOf("bar_code"));
    case PriceRole:
        return temp.value(temp.indexOf("price"));
    case DateRole:
        return temp.value(temp.indexOf("last_suplyed"));
    case SupplyerRole:
        return temp.value(temp.indexOf("supplyer"));
    default:
        break;
    }
    return QVariant();
}

QVariant InformationListModel::getLikePurchase(const QModelIndex &index, int role) const
{
    QSqlRecord temp = listData.at(index.row());
    switch (role) {
    case NameRole:
        return temp.value(temp.indexOf("product_name"));
    case MainIdRole:
        return temp.value(temp.indexOf("purchase_id"));
    case MarketIdRole:
        return temp.value(temp.indexOf("market_id"));
    case ProductCountRole:
        return temp.value(temp.indexOf("product_count"));
    case PriceRole:
        return temp.value(temp.indexOf("price"));
    case DateRole:
        return temp.value(temp.indexOf("date"));
    default:
        break;
    }
    return QVariant();
}

QVariant InformationListModel::getLikeAccounts(const QModelIndex &index, int role) const
{
   /* switch (currentTable) {
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
    }*/
    return QVariant();
}

void InformationListModel::goNext()
{
    this->cleanUp();
    this->fillUpPage();
    currentPage++;
}

void InformationListModel::goPrev()
{
    this->cleanUp();
    for(int i=0;i<1000;i++){
        lastQuery.previous();
        listData.push_front(lastQuery.record());
    }
    currentPage--;
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
    this->cleanUp();
    beginInsertRows(QModelIndex(),0,999);
    for(int i=0;i<1000;i++){
        listData.append(lastQuery.record());
        lastQuery.next();
    }
    endInsertRows();

}









