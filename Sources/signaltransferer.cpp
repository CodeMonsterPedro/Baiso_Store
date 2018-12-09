#include "../Headers/signaltransferer.h"

SignalTransferer::SignalTransferer(QObject *parent) : QObject(parent)
{

}

void SignalTransferer::goToPage(int number)
{
    qDebug()<<number;
    emit changePage(number);
}
