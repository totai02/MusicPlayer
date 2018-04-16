#ifndef MUSICPLAYER_H
#define MUSICPLAYER_H

#include <QObject>
#include <QMediaPlayer>
#include <QMediaPlaylist>

#include "entity/musicitem.h"

class MusicPlayer : public QObject
{
    Q_OBJECT
public:
    explicit MusicPlayer(QObject *parent = nullptr);

    Q_INVOKABLE void play(int index);

    Q_INVOKABLE void pause();

    Q_INVOKABLE void cont();

    Q_INVOKABLE int getVolumn();
    Q_INVOKABLE void setVolumn(int value);

    Q_INVOKABLE bool isPlaying();

    Q_INVOKABLE QString getMusicTitle() const;

    Q_INVOKABLE QString getMusicArtist() const;

    Q_INVOKABLE QString getMusicDuration();

    Q_INVOKABLE QString getMusicLength();

    Q_INVOKABLE float getProgress();

    Q_INVOKABLE void setMediaPosition(float);

    Q_INVOKABLE void nextMedia();

    Q_INVOKABLE void prevMedia();

    Q_INVOKABLE bool isShuffle();

    Q_INVOKABLE void setShuffle(bool);

    Q_INVOKABLE void setLoop(bool);

signals:
    void playPause(bool isPlay);
    void musicInfoSignal(int);
    void updateInfoSuccess();
    void updateDuration();
public slots:
    void receivePlay(int index, const MusicItem &item);
    void receivePlayList(const QVector<MusicItem> &list);
    void updateCurrentMediaInfo(QMediaPlayer::MediaStatus);
    void receiveMediaInfo(const MusicItem &item);
private:

    QString timeToString(int);

    QMediaPlayer player;
    QMediaPlaylist playList;

    MusicItem musicInfo;
    int musicIndex;

    bool isPlay = false;
    int volumn = 100;
    int duration;

    bool shuffle = false;
};

#endif // MUSICPLAYER_H
