#ifndef REPOSITORYU_H
#define REPOSITORYU_H

#include <QObject>

#include <QtSql>
#include<QSqlDatabase>
#include<QSqlQuery>
#include<QSqlError>
#include<QSqlField>
#include<QSqlIndex>
#include<QSqlRecord>

#include<QDebug>

#include<QStringList>
#include<QString>


class RepositoryU : public QObject
{
    Q_OBJECT
public:
    explicit RepositoryU(QObject *parent = nullptr);

    QStringList GetRequest(QString request);
    int SetRequest(QString request);


signals:

public slots:

private:
    bool isConnected=false;
};

#endif // REPOSITORYU_H
