#include "application.h"
#include <QDebug>

Application::Application(QObject *parent) : QObject(parent)
{

}

void Application::showLoading()
{
    emit sendSignal(true);
}

void Application::hideLoading()
{
    emit sendSignal(false);
}

void Application::setEngine(QQmlApplicationEngine *value)
{
    engine = value;
}

void Application::setApplication(QGuiApplication *app)
{
    this->app = app;
    loadLanguage();
}

bool Application::isLoading() const
{
    return loading;
}

int Application::getLanguage() const
{
    return language;
}

void Application::loadLanguage()
{   
    QFile file("language.dat");

    if (!file.open(QIODevice::ReadOnly | QIODevice::Text)){
        emit languageChange(0);
        return;
    }

    QTextStream in(&file);

    int lang = in.readLine().toInt();

    if (lang == VIETNAMESE){
        tranlator.load(":/language/language_vn.qm");
        language = lang;
    } else if (lang == FRANCE){
        tranlator.load(":/language/language_fr.qm");
        language = lang;
    } else {
        tranlator.load(":/language/language_en.qm");
        language = 0;
    }

    if (app){
        app->installTranslator(&tranlator);
    }
}

void Application::onShowLoading()
{
    loading = true;
    showLoading();
}

void Application::onHideLoading()
{
    loading = false;
    hideLoading();
}

void Application::changeLanguage(const int &lang)
{
    QFile file("language.dat");

    if (!file.open(QIODevice::WriteOnly | QIODevice::Text))
    return;


    QTextStream out(&file);

    out << lang;

    file.close();

    app->quit();
    QProcess::startDetached(app->arguments()[0], app->arguments());
}
