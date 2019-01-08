#include "repositoryu.h"

QSqlDatabase RepositoryU::db = QSqlDatabase::addDatabase("QPSQL");
bool RepositoryU::isConnected = false;
QSqlQuery RepositoryU::lastQuery;
QStringList RepositoryU::tables;

RepositoryU::RepositoryU(QObject *parent) : QObject(parent){}


QSqlQuery RepositoryU::GetRequest(QString request)
{
    QSqlQuery query;
    if(isConnected){
        qDebug()<<request;//need to handle a unexecutable request error
        if(!query.exec(request))qDebug()<<"cant execute request";
        else{
            lastQuery=query;
            return query;
        }
    }
    else {
        if(CreateConnection())return GetRequest(request);
        qDebug()<<request;
         // else error messege
    }
    return query;
}

int RepositoryU::SetRequest(QString request)
{
    QSqlQuery query;
    qDebug()<<request;
    if(!query.exec(request))qDebug()<<"cant execute request";
    return 0;
}

bool RepositoryU::CreateConnection()
{
    db.setDatabaseName("Baiso_main");
    db.setUserName("postgres");
    db.setHostName("127.0.0.1");
    db.setPassword("qwerty123");

    if(!db.open()){
        isConnected=false;
        qDebug()<<db.lastError();
        //messege about no database conntection
    }else{
        isConnected=true;
        tables = db.tables();
        foreach (QString str,tables){
            qDebug()<<"Table: "<<str;
        }
    }
    return isConnected;
}
