﻿#include <QGuiApplication>
#include <QQmlApplicationEngine>

#include"Headers/loginpageu.h"
#include"RepositoryU/repositoryu.h"
#include"Headers/signaltransferer.h"


int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);


    qmlRegisterType<logInPageU>("backend.login",1,0,"Backend_logIn");
    qmlRegisterType<SignalTransferer>("backend.transfer",1,0,"Backend_transfer");

    QQmlApplicationEngine engine;
    engine.load(QUrl(QStringLiteral("qrc:/UIs/UIs/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
