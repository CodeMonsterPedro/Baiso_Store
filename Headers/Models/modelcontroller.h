#ifndef MODELCONTROLLER_H
#define MODELCONTROLLER_H

#include <QObject>
#include <QDebug>
#include"informationlistmodel.h"

class ModelController : public QObject
{
    Q_OBJECT
    InformationListModel* m_myModel;

    QStringList m_list;

public:

    Q_PROPERTY(QStringList list READ list WRITE setList NOTIFY listChanged)

    Q_PROPERTY(InformationListModel* myModel READ myModel WRITE setMyModel NOTIFY myModelChanged)

    ModelController(QObject *parent = Q_NULLPTR);
    ~ModelController();

    InformationListModel* myModel() const{
        qDebug()<<"try to get a model data";
        qDebug()<<m_myModel->listData;
        return m_myModel;
    }
    QStringList list() const{return RepositoryU::tables;}
    Q_INVOKABLE void showFrom(int source);
    Q_INVOKABLE int addNewElementToRep(QString str);
    Q_INVOKABLE void goNext();
    Q_INVOKABLE void goPrev();

public slots:
    void setMyModel(InformationListModel* myModel);
    void setList(QStringList list);

signals:
    void myModelChanged(InformationListModel* myModel);
    void listChanged(QStringList list);

};

#endif // MODELCONTROLLER_H
