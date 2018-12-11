#include "../../Headers/Models/informationlistmodel.h"

InformationListModel::InformationListModel()
{

}

void InformationListModel::GetTopTen()
{
    QSqlRecord record = RepositoryU::GetRequest("SELECT DISTINCT id, product_name FROM public.\"ProductSalseFull\" ");
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
    std::max_element(totalCountList.begin(),totalCountList.end());
}


