#include "../../Headers/Models/informationlistmodel.h"

InformationListModel::InformationListModel(QObject *parent) : QAbstractListModel(parent)
{
    sourceList.append("ProductList");
    sourceList.append("ProductSaleFull");
    sourceList.append("ProductPlan");
}

QHash<int, QByteArray> InformationListModel::roleNames() const
{
    QHash<int, QByteArray> roles = QAbstractListModel::roleNames();
    roles[NameRole] = "m_Name";
    roles[MainIdRole] = "m_MainId";
    roles[MarketIdRole] = "m_MarketId";
    roles[PurchaseIdRole] = "m_PurchId";
    roles[ProductCountRole] = "m_ProductCount";
    roles[InBoxCountRole] = "m_InBoxCount";
    roles[CountSystemRole] = "m_CountSys";
    roles[BarCodeRole] = "m_BarCode";
    roles[PriceRole] = "m_Price";
    roles[DateRole] = "m_Date";
    roles[SupplyerRole] = "m_Supplyer";
    roles[CompanyRole] = "m_Company";
    qDebug()<<"roleNames\n";
    return roles;
}

int InformationListModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
//            qDebug()<<"LIST DATA SIZE - " + QString::number(listData.size()) + " xx " + QString::number(parent.row()) + " yy " + QString::number(parent.column());
    return listData.count();
}

QVariant InformationListModel::data(const QModelIndex &index, int role) const
{
    if(index.row()>=rowCount())return QVariant();
    switch (currentTable) {
    case 0:
        return getLikeProduct(index,role);
    case 1:
        return getLikePurchase(index,role);
    case 2:
        return getLikePlan(index,role);
    case 3:
    case 4:
    default:
        break;
    }
    return QVariant();
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
    QString table=sourceList[source];
    lastQuery = RepositoryU::GetRequest(QString("SELECT * FROM public.\"%1\" ").arg(table));
    // lastQuery.
    // columnsNames;
    this->fillUpPage();
    this->UpdateMaxPage();
}

void InformationListModel::cleanUp()
{
   while(!listData.isEmpty())delElementLast();
}

void InformationListModel::fillUpPage()
{
    lastQuery.seek(0);
    for(int i=0;i<(lastQuery.size()>1000? 1000 : lastQuery.size());i++){
        addElement(lastQuery.record());
        lastQuery.next();
    }
}

void InformationListModel::UpdateMaxPage()
{
    currentPage = 1;
    maxPage = lastQuery.size()%1000==0? lastQuery.size()/1000 : (lastQuery.size()/1000) + 1;
}

QVariant InformationListModel::getLikeProduct(const QModelIndex &index, int role) const
{
    //qDebug()<<"getLikeProduct";
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
    case CompanyRole:
        return temp.value(temp.indexOf("company"));
    default:
        break;
    }
    return QVariant();
}

QVariant InformationListModel::getLikePurchase(const QModelIndex &index, int role) const
{
    //qDebug()<<"getLikePurchase";
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
    case CountSystemRole:
        return temp.value(temp.indexOf("count_sys")).toInt()? "item" : "kgs";
    default:
        break;
    }
    return QVariant();
}

QVariant InformationListModel::getLikeAccounts(const QModelIndex &index, int role) const
{
    //qDebug()<<"getLikeAccount";
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

QVariant InformationListModel::getLikePlan(const QModelIndex &index, int role) const
{
    //qDebug()<<"getLikePlan";
    QSqlRecord temp = listData.at(index.row());
    switch (role) {
    case NameRole:
        return temp.value(temp.indexOf("product"));
    case BarCodeRole:
        return temp.value(temp.indexOf("bar-code"));
    case ProductCountRole:
        return temp.value(temp.indexOf("count"));
    default:
        break;
    }
    return QVariant();
}

QVariant InformationListModel::getLikeBigSale(const QModelIndex &index, int role) const
{

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


void InformationListModel::addElement(QSqlRecord value)
{
    beginInsertRows(QModelIndex(), listData.size(), listData.size());
    listData.append(value);
    endInsertRows();
    emit dataChanged();
}

void InformationListModel::delElementLast()
{
    if(listData.isEmpty()){
        return;
    }
    beginRemoveRows(QModelIndex(),listData.indexOf(listData.last()),listData.indexOf(listData.last()));
    listData.removeLast();
    endRemoveRows();
    emit dataChanged();
}

void InformationListModel::Refresh()
{
    this->cleanUp();
    for(int i=0;i<(lastQuery.size()>1000? 1000 : lastQuery.size());i++)lastQuery.previous();
    for(int i=0;i<(lastQuery.size()>1000? 1000 : lastQuery.size());i++){
        addElement(lastQuery.record());
        lastQuery.next();
    }
}

void InformationListModel::fillUpBigSale()
{
    QSqlQuery tempq = RepositoryU::GetRequest(QString("SELECT distinct purchase_id FROM public.\"ProductSaleFull\""));
    QList<int> purchaseList;
    while(tempq.next()){
        purchaseList.append(tempq.record().value(tempq.record().indexOf("purchase_id")).toInt());
    }
    for(int i=0;i<purchaseList.size();i++){
        BigSaleElement sbE;
        tempq = RepositoryU::GetRequest(QString("SELECT product_name, product_count, price, date  FROM public.\"ProductSaleFull\" WHERE purchase_id=%1").arg(purchaseList[i]));
        while(tempq.next()){
            sbE.productNames.append(tempq.record().value(tempq.record().indexOf("product_name")).toString());
            sbE.productCount.append(tempq.record().value(tempq.record().indexOf("product_count")).toInt());
            sbE.productPrice.append(tempq.record().value(tempq.record().indexOf("price")).toDouble());
        }
        sbE.date = tempq.record().value(tempq.record().indexOf("date")).toString();
        sbE.purchaseId = purchaseList[i];
        bigSaleList.append(sbE);
    }
}









