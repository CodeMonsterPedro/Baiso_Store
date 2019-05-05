#ifndef MODELCONTROLLER_H
#define MODELCONTROLLER_H

#include <QObject>
#include <QDebug>
#include"informationlistmodel.h"

class ModelController : public QObject
{
    Q_OBJECT
    InformationListModel* m_myModel;
    InformationListModel* m_myPlan;
    InformationListModel* bigSaleList;

    QStringList* m_list;
    QStringList columnsNameL;
	QStringList productColumns;

    int maxPageCount, currentPageCount;
    int currentTableColumnsCount;

public:

    Q_PROPERTY(int maxPage READ maxPage WRITE setMaxPage NOTIFY maxPageChanged)
    Q_PROPERTY(int currentPage READ currentPage WRITE setCurrentPage NOTIFY currentPageChanged)
    Q_PROPERTY(QStringList list READ list WRITE setList NOTIFY listChanged)
    Q_PROPERTY(InformationListModel* myModel READ myModel WRITE setMyModel NOTIFY myModelChanged)
    Q_PROPERTY(InformationListModel* myPlan READ myPlan WRITE setMyPlan NOTIFY myPlanChanged)
    Q_PROPERTY(InformationListModel* bsList READ bsList WRITE setbsList NOTIFY bsListChanged)
    Q_PROPERTY(QStringList columnsNames READ colName WRITE setcolName NOTIFY colNameChanged)
    Q_PROPERTY(QStringList productColumnNames READ productColumnNames WRITE setProductColumnNames NOTIFY productColumnNamesChanged)

    ModelController(QObject *parent = Q_NULLPTR);
    ~ModelController();

    InformationListModel* myModel();
    InformationListModel* myPlan();
    QStringList list();
    int maxPage();
    int currentPage();
    QStringList colName();
	QStringList productColumnNames();
    InformationListModel* bsList();
    
    int myStore;
    void PlanCheck();

    Q_INVOKABLE void showFrom(int source);
    Q_INVOKABLE void showFromPlan(int source, QString str);
    Q_INVOKABLE int addNewProductToRep(QString str);
    Q_INVOKABLE int addNewPurchaseToRep(QString str);
    Q_INVOKABLE int addNewFullPurchaseToRep(QString str, QStringList strl);
    Q_INVOKABLE int addNewAccountToRep(QString str);
    Q_INVOKABLE void goNext();
    Q_INVOKABLE void goPrev();
    Q_INVOKABLE void toggleListType();
    Q_INVOKABLE void setMyStore(int x);
    Q_INVOKABLE void deleteItems(QString,int,QString teble);
    Q_INVOKABLE void updatePlan(QString, int, QString);
    Q_INVOKABLE void updateProduct(QString, QString);
    Q_INVOKABLE void updateFullPurchase(QString, QStringList);

public slots:
    void onDataChanged();
    void setMyModel(InformationListModel* myModel);
    void setMyPlan(InformationListModel* myPlan);
    void setList(QStringList list);
    void setMaxPage(int max);
    void setCurrentPage(int current);
    void setcolName(QStringList strl);
    void setProductColumnNames(QStringList strl);
    void setbsList(InformationListModel* list);

signals:
    void myModelChanged();
    void myPlanChanged();
    void listChanged();
    void maxPageChanged();
    void currentPageChanged();
    void colNameChanged();
    void productColumnNamesChanged();
    void bsListChanged();

};

#endif // MODELCONTROLLER_H
