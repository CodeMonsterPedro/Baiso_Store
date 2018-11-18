#include "Headers/loginpageu.h"
#include<QDebug>

logInPageU::logInPageU(QObject *parent) : QObject(parent)
{

}

void logInPageU::sendRequest(QString login, QString password)
{
    qDebug()<<"log - " + login + " \t pass - " + password;
    qDebug()<<"OK!!!";

}



