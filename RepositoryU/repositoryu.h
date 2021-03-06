﻿#ifndef REPOSITORYU_H
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

    static QSqlQuery GetRequest(QString request);
    Q_INVOKABLE  static int SetRequest(QString request);
    static bool isConnected;
    static QSqlDatabase db;
    static QSqlQuery lastQuery;
    static QStringList tables;

signals:

public slots:

private:
    static bool CreateConnection();


};

#endif // REPOSITORYU_H
