#include "Headers/loginpageu.h"
#include<QDebug>

logInPageU::logInPageU(QObject *parent) : QObject(parent)
{
    qDebug()<<RepositoryU::isConnected;
}

int logInPageU::sendRequest(QString login, QString password)
{
    QStringList strl = RepositoryU::GetRequest("SELECT role FROM account WHERE log=" + login + " AND pass="+password);
    qDebug()<<"login - " + login + " Password - " + password;
    return 0;
}



