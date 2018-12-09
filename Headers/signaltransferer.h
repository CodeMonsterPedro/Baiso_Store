#ifndef SIGNALTRANSFERER_H
#define SIGNALTRANSFERER_H
#include<QObject>
#include<QDebug>
class SignalTransferer : public QObject
{
    Q_OBJECT
public:
    explicit SignalTransferer(QObject *parent = nullptr);
    Q_INVOKABLE void goToPage(int number);

signals:
    void changePage(int number);

public slots:
};

#endif // SIGNALTRANSFERER_H
