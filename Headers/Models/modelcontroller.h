#ifndef MODELCONTROLLER_H
#define MODELCONTROLLER_H

#include <QObject>
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

InformationListModel* myModel() const{return m_myModel;}
QStringList list() const{return m_list;}
Q_INVOKABLE void showFrom(int source);
public slots:
void setMyModel(InformationListModel* myModel);
void setList(QStringList list);

signals:
void myModelChanged(InformationListModel* myModel);
void listChanged(QStringList list);
};

#endif // MODELCONTROLLER_H
