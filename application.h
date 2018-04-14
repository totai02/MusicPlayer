#ifndef APPLICATION_H
#define APPLICATION_H

#include <QObject>
#include <QQmlApplicationEngine>

class Application : public QObject
{
    Q_OBJECT
public:
    explicit Application(QObject *parent = nullptr);

    Q_INVOKABLE void showLoading();

    Q_INVOKABLE void hideLoading();

    void setEngine(QQmlApplicationEngine *value);

private:

    QQmlApplicationEngine *engine;

signals:

    void sendSignal(bool value);

public slots:

    void onShowLoading();
    void onHideLoading();

};

#endif // APPLICATION_H
