#ifndef LOGINPAGEU_H
#define LOGINPAGEU_H

#include<QObject>
#include<QString>


class logInPageU : public QObject
{
    Q_OBJECT


public:
    explicit logInPageU(QObject *parent = nullptr);

    Q_INVOKABLE void sendRequest(QString login, QString password);


signals:

public slots:

private:

    QString Login="";
    QString Password="";

};

#endif // LOGINPAGEU_H
