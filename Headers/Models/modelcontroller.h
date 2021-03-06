﻿#ifndef MODELCONTROLLER_H
#define MODELCONTROLLER_H

#include <QObject>
#include <QDebug>
#include <QTextDocument>
#include <QPrinter>
#include <QPrintDialog>
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
    QStringList products;
    QStringList products_const;
    QStringList bsProducts;
    QStringList bsCount;
    QStringList bsPrice;
    QStringList searchProduct;
    QStringList searchBarCode;
    QString inputString;


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
    Q_PROPERTY(QStringList productNames READ productNames WRITE setProductNames NOTIFY productNamesChanged)
    Q_PROPERTY(QStringList productSearch READ productSearch WRITE setProductSearch NOTIFY productSearchChanged)
    Q_PROPERTY(QStringList bigSaleProducts READ bigSaleProducts WRITE setBigSaleProducts NOTIFY bigSaleProductsChanged)
    Q_PROPERTY(QStringList bigSaleCount READ bigSaleCount WRITE setBigSaleCount NOTIFY bigSaleCountChanged)
    Q_PROPERTY(QStringList bigSalePrice READ bigSalePrice WRITE setBigSalePrice NOTIFY bigSalePriceChanged)
    Q_PROPERTY(QString searchString READ searchString WRITE setSearchString NOTIFY searchStringChanged)

    ModelController(QObject *parent = Q_NULLPTR);
    ~ModelController();

    InformationListModel* myModel();
    InformationListModel* myPlan();
    QStringList list();
    int maxPage();
    int currentPage();
    QStringList colName();
	QStringList productColumnNames();
    QStringList productNames();
    InformationListModel* bsList();
    QStringList bigSaleProducts();
    QStringList bigSaleCount();
    QStringList bigSalePrice();
    QStringList productSearch();
    QString searchString();

    
    int myStore;
    void PlanCheck();
    void DataGenerator();

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
    Q_INVOKABLE void printBigSale(int id);
    Q_INVOKABLE void printPlan(int store);
    Q_INVOKABLE void useProduct(QString str);
    Q_INVOKABLE void refreshProducts();
    Q_INVOKABLE bool isCorrectCount(QString str,int count);
    Q_INVOKABLE void setCurrentBigSale(int id);
    Q_INVOKABLE int getProductMaxValue(QString str);
    Q_INVOKABLE void sortBy(int id);
    Q_INVOKABLE void search(QString str);
    Q_INVOKABLE void resetProductSearch();
    Q_INVOKABLE void resetBarCodeSearch();
    Q_INVOKABLE void searchPlan(QString str);
    Q_INVOKABLE void searchBigSale(QString str);
    Q_INVOKABLE void searchProducts(QString str);
    Q_INVOKABLE void searchReset();
    Q_INVOKABLE void acceptAll(QString y);
    Q_INVOKABLE void acceptIt(QString str, int x, QString y);
    Q_INVOKABLE void dateFilter(QString date1, QString date2, int x);


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
    void setProductNames(QStringList strl);
    void setBigSaleProducts(QStringList strl);
    void setBigSaleCount(QStringList strl);
    void setBigSalePrice(QStringList strl);
    void setProductSearch(QStringList strl);
    void setSearchString(QString str);

signals:
    void myModelChanged();
    void myPlanChanged();
    void listChanged();
    void maxPageChanged();
    void currentPageChanged();
    void colNameChanged();
    void productColumnNamesChanged();
    void bsListChanged();
    void productNamesChanged();
    void currentBigSaleSetted();
    void bigSaleProductsChanged();
    void bigSaleCountChanged();
    void bigSalePriceChanged();
    void productSearchChanged();
    void searchStringChanged();

};

#endif // MODELCONTROLLER_H
