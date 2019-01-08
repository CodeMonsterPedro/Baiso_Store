#include "../../Headers/Models/modelcontroller.h"

ModelController::ModelController(QObject *parent) : QObject(parent),m_myModel(new InformationListModel())
{
}

ModelController::~ModelController()
{
    delete m_myModel;
}

void ModelController::showFrom(int source)
{
    m_myModel->showfrom(source);
    qDebug()<<"I say - "<<m_myModel->data(QModelIndex(),Qt::UserRole) ;
    setMyModel(m_myModel);
    emit myModelChanged(m_myModel);
}

void ModelController::setMyModel(InformationListModel* myModel)
{
    if (m_myModel == myModel)
        return;

    m_myModel = myModel;
    emit myModelChanged(m_myModel);
}
void ModelController::setList(QStringList list)
{
    if (m_list == list)
        return;

    m_list = list;
    emit listChanged(m_list);
}
