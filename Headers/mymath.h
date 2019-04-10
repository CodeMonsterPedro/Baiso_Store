#ifndef MYMATH_H
#define MYMATH_H

#include <QObject>

class MyMath : public QObject
{
    Q_OBJECT
public:
    explicit MyMath(QObject *parent = nullptr);

signals:

public slots:
};

#endif // MYMATH_H