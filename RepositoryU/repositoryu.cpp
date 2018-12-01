#include "repositoryu.h"

QSqlDatabase RepositoryU::db = QSqlDatabase::addDatabase("QPSQL");
bool RepositoryU::isConnected = false;

RepositoryU::RepositoryU(QObject *parent) : QObject(parent)
{
    db.setDatabaseName("HUI");
    db.setUserName("HUI");
    db.setHostName("HUI");
    db.setPassword("123");

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
}


QStringList RepositoryU::GetRequest(QString request)
{
    QStringList requestResult;

    if(isConnected){
        qDebug()<<request;
        return requestResult;
    }
    else {
        if(CreateConnection())return GetRequest(request);
        qDebug()<<request;
         // else error messege
    }
    return requestResult;
}

int RepositoryU::SetRequest(QString request)
{
    qDebug()<<request;
    return 0;
}

bool RepositoryU::CreateConnection()
{
    db.setUserName("HUI");
    db.setHostName("HUI");
    db.setPassword("123");

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
