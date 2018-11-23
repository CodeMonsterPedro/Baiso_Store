#include "repositoryu.h"

RepositoryU::RepositoryU(QObject *parent) : QObject(parent)
{
    QSqlDatabase db = QSqlDatabase::addDatabase("QPSQL");
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
    return requestResult;
}

int RepositoryU::SetRequest(QString request)
{
    return 0;
}
