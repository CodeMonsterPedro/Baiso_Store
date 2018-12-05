#include "repositoryu.h"

QSqlDatabase RepositoryU::db = QSqlDatabase::addDatabase("QPSQL");
bool RepositoryU::isConnected = false;
QSqlQuery RepositoryU::lastQuery;

RepositoryU::RepositoryU(QObject *parent) : QObject(parent){}


QSqlRecord RepositoryU::GetRequest(QString request)
{
    QSqlQuery query;
    if(isConnected){
        qDebug()<<request;//need to handle a unexecutable request error
        if(!query.exec(request))qDebug()<<"cant execute request";
        else{
            lastQuery=query;
            return query.record();
        }
    }
    else {
        if(CreateConnection())return GetRequest(request);
        qDebug()<<request;
         // else error messege
    }
    return query.record();
}

int RepositoryU::SetRequest(QString request)
{
    qDebug()<<request;
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
        QStringList tables = db.tables();
        foreach (QString str,tables){
            qDebug()<<"Table: "<<str;
        }
    }
    return isConnected;
}
