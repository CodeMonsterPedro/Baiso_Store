#ifndef MODELCONTROLLER_H
#define MODELCONTROLLER_H

#include <QObject>
#include <QDebug>
#include"informationlistmodel.h"

class ModelController : public QObject
{
    Q_OBJECT
    InformationListModel* m_myModel;

    QStringList* m_list;
    QStringList columnsNameL;

    int maxPageCount, currentPageCount;
    int currentTableColumnsCount;

public:

    Q_PROPERTY(int maxPage READ maxPage WRITE setMaxPage NOTIFY maxPageChanged)
    Q_PROPERTY(int currentPage READ currentPage WRITE setCurrentPage NOTIFY currentPageChanged)
    Q_PROPERTY(QStringList list READ list WRITE setList NOTIFY listChanged)
    Q_PROPERTY(InformationListModel* myModel READ myModel WRITE setMyModel NOTIFY myModelChanged)
    Q_PROPERTY(QStringList columnsNames READ colName WRITE setcolName NOTIFY colNameChanged)

    ModelController(QObject *parent = Q_NULLPTR);
    ~ModelController();

    InformationListModel* myModel();
    QStringList list();
    int maxPage();
    int currentPage();
    QStringList colName(){return columnsNameL;}

    Q_INVOKABLE void showFrom(int source);
    Q_INVOKABLE int addNewElementToRep(QString str);
    Q_INVOKABLE void goNext();
    Q_INVOKABLE void goPrev();
    Q_INVOKABLE void toggleListType();
    Q_INVOKABLE void deleteItems(QString,int);
public slots:
    void onDataChanged();
    void setMyModel(InformationListModel* myModel);
    void setList(QStringList list);
    void setMaxPage(int max);
    void setCurrentPage(int current);
    void setcolName(QStringList strl);

signals:
    void myModelChanged();
    void listChanged();
    void maxPageChanged();
    void currentPageChanged();
    void colNameChanged();

};

#endif // MODELCONTROLLER_H
