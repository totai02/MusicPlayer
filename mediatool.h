#ifndef MEDIATOOL_H
#define MEDIATOOL_H

#include <QObject>
#include <QProcess>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonValue>
#include <QJsonArray>

class MediaTool : public QObject
{
    Q_OBJECT
public:
    explicit MediaTool(QObject *parent = nullptr);

signals:
    void resultReady(const QJsonArray &result);

public slots:

    void getMediaArray(QString);
};

#endif // MEDIATOOL_H
