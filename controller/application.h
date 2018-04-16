#ifndef APPLICATION_H
#define APPLICATION_H

#include <QObject>
#include <QQmlApplicationEngine>
#include <QGuiApplication>
#include <QTranslator>
#include <QProcess>
#include <QFile>

class Application : public QObject
{
    Q_OBJECT
public:

    enum {
        ENGLISH,
        FRANCE,
        VIETNAMESE
    };

    explicit Application(QObject *parent = nullptr);

    Q_INVOKABLE void showLoading();

    Q_INVOKABLE void hideLoading();

    Q_INVOKABLE void changeLanguage(const int &lang);

    Q_INVOKABLE int getLanguage() const;

    void setEngine(QQmlApplicationEngine *value);

    void setApplication(QGuiApplication *app);


private:

    int language;

    QQmlApplicationEngine *engine;
    QGuiApplication *app;
    QTranslator tranlator;

    void loadLanguage();

signals:

    void sendSignal(bool value);
    void languageChange(int value);

public slots:

    void onShowLoading();
    void onHideLoading();

};

#endif // APPLICATION_H
