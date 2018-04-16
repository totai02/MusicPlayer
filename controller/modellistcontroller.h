#ifndef MODELLISTCONTROLLER_H
#define MODELLISTCONTROLLER_H

#include <QObject>

class ModelListController : public QObject
{
    Q_OBJECT
public:
    explicit ModelListController(QObject *parent = nullptr);

signals:

    void preItemAppended();
    void postItemAppended();

    void preItemClear();
    void postItemClear();

public slots:
};

#endif // MODELLISTCONTROLLER_H
