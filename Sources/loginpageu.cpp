#include "Headers/loginpageu.h"
#include<QDebug>

logInPageU::logInPageU(QObject *parent) : QObject(parent){}

int logInPageU::sendRequest(QString login, QString password)
{
    QSqlQuery query = RepositoryU::GetRequest("SELECT role FROM public.\"Accounts\" WHERE login=\'" + login + "\' AND password=\'"+password+"\'");
    query.next();
    QSqlRecord record = query.record();
    QString role = record.value(record.indexOf("role")).toString();
    if(role == "admin")return 0;
    if(role == "manager") return 1;
    if(role == "storageman")return 2;
    return 3;
}

int logInPageU::getMarket(QString login, QString password)
{
    QSqlQuery query = RepositoryU::GetRequest("SELECT store FROM public.\"Accounts\" WHERE login=\'" + login + "\' AND password=\'"+password+"\'");
    query.next();
    QSqlRecord record = query.record();
    int role = record.value(record.indexOf("store")).toInt();
    return role;
}

void logInPageU::getDisconnect()
{
    Login = "";
    Password = "";
}



