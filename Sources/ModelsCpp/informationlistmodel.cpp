#include "../../Headers/Models/informationlistmodel.h"

InformationListModel::InformationListModel(QObject *parent) : QAbstractListModel(parent)
{
    sourceList.append("ProductSaleFull");
    sourceList.append("ProductList");

    QStringList temp;
    QSqlRecord record = RepositoryU::GetRequest(QString("SELECT * FROM public.\"ProductSaleFull\" "));
    QSqlQuery query = RepositoryU::lastQuery;
    while(query.next()){
        QString str =QString("|%7|(%1)-(%2)-(%4). %3 - %5 : %6$")
                .arg(query.value(record.indexOf("id")).toString())
                .arg(query.value(record.indexOf("market_id")).toString())
                .arg(query.value(record.indexOf("product_name")).toString())
                .arg(query.value(record.indexOf("purchase_id")).toString())
                .arg(query.value(record.indexOf("product_count")).toString())
                .arg(query.value(record.indexOf("price")).toString())
                .arg(query.value(record.indexOf("date")).toString());
        temp.append(str);
    }
    listData=temp;
}

QHash<int, QByteArray> InformationListModel::roleNames() const
{
    QHash<int, QByteArray> roles = QAbstractListModel::roleNames();
    roles[IconRole] = "mIcon";
    roles[TextRole] = "mText";

    return roles;
}

int InformationListModel::rowCount(const QModelIndex &parent) const
{
    Q_UNUSED(parent);
    return listData.size();
}

QVariant InformationListModel::data(const QModelIndex &index, int role) const
{
    switch (role) {
    case TextRole:
        qDebug()<<"----"+QString::number(index.row());
        return listData.at(index.row());
    case IconRole:
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
    QString table=sourceList[source];
    QStringList temp;
    QSqlRecord record = RepositoryU::GetRequest(QString("SELECT * FROM public.\"%1\" ").arg(table));
    QSqlQuery query = RepositoryU::lastQuery;
    if(source==0){
        while(query.next()){
            QString str =QString("|%7|(%1)-(%2)-(%4). %3 - %5 : %6$")
                    .arg(query.value(record.indexOf("id")).toString())
                    .arg(query.value(record.indexOf("market_id")).toString())
                    .arg(query.value(record.indexOf("product_name")).toString())
                    .arg(query.value(record.indexOf("purchase_id")).toString())
                    .arg(query.value(record.indexOf("product_count")).toString())
                    .arg(query.value(record.indexOf("price")).toString())
                    .arg(query.value(record.indexOf("date")).toString());
            temp.append(str);
        }
    }
    if(source==1){
        QString count;
        while(query.next()){
            count=GetCountSystem(query.value(record.indexOf("count_sys")).toInt());
            QString str =QString("(%1). %5.%2 - %3 items/box : %4$/%6 \\nSupplyed by: %7")
                    .arg(query.value(record.indexOf("id")).toString())
                    .arg(query.value(record.indexOf("product_name")).toString())
                    .arg(query.value(record.indexOf("in_box_count")).toString())
                    .arg(query.value(record.indexOf("price")).toString())
                    .arg(query.value(record.indexOf("company")).toString())
                    .arg(count).arg(query.value(record.indexOf("supplyer")).toString());
            temp.append(str);
        }
    }
    Refresh(temp);

}

void InformationListModel::Refresh(QStringList temp)
{
    beginRemoveRows(QModelIndex(),0, listData.size());
    listData.clear();
    beginInsertRows(QModelIndex(),0,listData.size());
    listData=temp;
    endInsertRows();
    endRemoveRows();
}









