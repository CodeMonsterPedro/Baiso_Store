#include "Headers/loginpageu.h"
#include<QDebug>

logInPageU::logInPageU(QObject *parent) : QObject(parent)
{

}

bool logInPageU::sendRequest(QString login, QString password)
{
    qDebug()<<"log - " + login + " \t pass - " + password;
    qDebug()<<"OK!!!";
    return false;
}



