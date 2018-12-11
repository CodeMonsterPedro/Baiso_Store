#ifndef INFORMATIONLISTMODEL_H
#define INFORMATIONLISTMODEL_H
#include<QObject>
#include<QString>
#include<QStringList>
#include<QVector>
#include<QtAlgorithms>
#include"../../RepositoryU/repositoryu.h"

class InformationListModel
{
public:
    InformationListModel();
    QStringList listData;

private:
    void GetTopTen();
};

#endif // INFORMATIONLISTMODEL_H
