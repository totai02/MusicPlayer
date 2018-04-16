#ifndef MUSICLISTCONTROLLER_H
#define MUSICLISTCONTROLLER_H

#include <iostream>
#include <filesystem>
#include <string>

#include <QObject>
#include <QVector>
#include <QProcess>
#include <QJsonDocument>
#include <QJsonObject>
#include <QJsonValue>
#include <QJsonArray>
#include <QThread>

#include "entity/musicitem.h"
#include "entity/folderitem.h"
#include "tool/mediatool.h"


class MusicList : public QObject
{
    Q_OBJECT
public:
    explicit MusicList(QObject *parent = nullptr);

    ~MusicList(){
        thread.quit();
        thread.wait();
    }

    Q_INVOKABLE int count();

    Q_INVOKABLE void removeAll();

    QVector<MusicItem> items() const;

    void setMediaTool(MediaTool *value);

    void getFullDataFromTool();

signals:
    void setMusicList(const QVector<MusicItem> &list);

    void preAppendItem();
    void postAppendItem();
    void preRemoveAllItem();
    void postRemoveAllItem();

    void loadComplete();
    void sendMusicInfo(const MusicItem &item);

    void getDataFromMediaTool(const QString &);

    void showLoading();

    void emptyToShow();

public slots:

    void receiveDataFromMediaTool(const QJsonArray &result);
    void receiveMusicList(const QVector<FolderItem> &list);
    void getMusicInfo(int index);

private:

    int waitingMediaTool = 0;

    QVector<MusicItem> mList;

    QJsonObject getMediaInfo(const QJsonObject &obj);

    QThread thread;

};

#endif // MUSICLISTCONTROLLER_H
