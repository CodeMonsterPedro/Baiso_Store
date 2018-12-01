#ifndef LOGINPAGEU_H
#define LOGINPAGEU_H

#include<QObject>
#include<QString>
#include"RepositoryU/repositoryu.h"


class logInPageU : public QObject
{
    Q_OBJECT


public:
    explicit logInPageU(QObject *parent = nullptr);

    Q_INVOKABLE int sendRequest(QString login, QString password);


signals:

public slots:

private:
    QString Login="";
    QString Password="";

};

#endif // LOGINPAGEU_H
