#include "mediatool.h"

MediaTool::MediaTool(QObject *parent) : QObject(parent)
{

}

void MediaTool::getMediaArray(QString folderName)
{
    QProcess *mediaInfo = new QProcess(this);
    mediaInfo->start("MediaInfo/mediainfo", QStringList() << "--Output=JSON" << folderName.append("/*.mp3"));
    mediaInfo->waitForReadyRead();

    QByteArray jsonData("[");
    QString currentObject;
    while (!mediaInfo->atEnd()){
        QString line = mediaInfo->readLine();
        if (line.compare("}{\r\n") == 0){
            currentObject.append("}");
            jsonData.append(currentObject);
            jsonData.append(",");
            currentObject = "{";
        } else {
            currentObject.append(line);
        }

    }

    jsonData.append(currentObject);
    jsonData.append("]");
    QJsonDocument jsonDoc = QJsonDocument::fromJson(jsonData);
    QJsonArray arrayObject = jsonDoc.array();

    emit resultReady(arrayObject);

}
