#include <QGuiApplication>
#include <QQmlApplicationEngine>
#include <QQmlContext>

#include"Headers/loginpageu.h"
#include"Headers/analiticitem.h"
#include"RepositoryU/repositoryu.h"
#include"Headers/Models/modelcontroller.h"

#include"Headers/Models/informationlistmodel.h"


int main(int argc, char *argv[])
{
    QCoreApplication::setAttribute(Qt::AA_EnableHighDpiScaling);

    QGuiApplication app(argc, argv);
    QQmlApplicationEngine engine;

    RepositoryU::GetRequest("Select * from public.\"Accounts\"");

    qmlRegisterType<logInPageU>("backend.login",1,0,"Backend_logIn");
    qmlRegisterType<AnaliticItem>("analitic_item",1,0,"Analitic");
    QScopedPointer<ModelController> ptr(new ModelController());
    engine.rootContext()->setContextProperty("simpleModelController",ptr.data());
    qDebug()<<"main loaded"<<endl;
    engine.load(QUrl(QStringLiteral("qrc:/UIs/UIs/main.qml")));
    if (engine.rootObjects().isEmpty())
        return -1;

    return app.exec();
}
