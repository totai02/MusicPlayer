#include "application.h"

Application::Application(QObject *parent) : QObject(parent)
{

}

void Application::showLoading()
{

}

void Application::hideLoading()
{

}

void Application::setEngine(QQmlApplicationEngine *value)
{
    engine = value;
}

void Application::onShowLoading()
{
    emit sendSignal(true);
}

void Application::onHideLoading()
{
    emit sendSignal(false);
}
