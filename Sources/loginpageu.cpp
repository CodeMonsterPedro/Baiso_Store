#include "Headers/loginpageu.h"
#include<QDebug>

logInPageU::logInPageU(QObject *parent) : QObject(parent)
{
    qDebug()<<"DBs Connection status - "<<RepositoryU::isConnected;
}

int logInPageU::sendRequest(QString login, QString password)
{
    QSqlQuery query = RepositoryU::GetRequest("SELECT id FROM public.\"Accounts\" WHERE login=\'" + login + "\' AND password=\'"+password+"\'");
    QSqlRecord record = query.record();
    query.next();
    int role = query.value(record.indexOf("id")).toInt();
    qDebug()<<"Role - " + QString::number(role);
    return role;
}



