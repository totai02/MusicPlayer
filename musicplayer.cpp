#include "musicplayer.h"

MusicPlayer::MusicPlayer(QObject *parent) : QObject(parent)
{

}

void MusicPlayer::play(int index)
{
    musicIndex = index;

    playList.setCurrentIndex(index);
    player.setVolume(volumn);
    player.play();
    isPlay = true;
    emit playPause(isPlay);
}

void MusicPlayer::pause()
{
    player.pause();
    isPlay = false;
    emit playPause(isPlay);
}

void MusicPlayer::cont()
{
    player.play();
    isPlay = true;
    emit playPause(isPlay);
}

int MusicPlayer::getVolumn()
{
    return volumn;
}

void MusicPlayer::setVolumn(int value)
{
    volumn = value;
    player.setVolume(volumn);
}


bool MusicPlayer::isPlaying()
{
    return isPlay;
}

QString MusicPlayer::getMusicTitle() const
{
    return musicInfo.getTitle();
}

QString MusicPlayer::getMusicArtist() const
{
    return musicInfo.getArtist();
}

QString MusicPlayer::getMusicDuration()
{
    return timeToString(duration);
}

QString MusicPlayer::getMusicLength()
{
    return timeToString(musicInfo.getLength());
}

float MusicPlayer::getProgress()
{
    return (float) duration / musicInfo.getLength();
}

void MusicPlayer::setMediaPosition(float value)
{
    player.setPosition((value * musicInfo.getLength()) * 1000);
}

void MusicPlayer::nextMedia()
{
    if (!shuffle)
        playList.next();
    else playList.setCurrentIndex(rand() % playList.mediaCount());
}

void MusicPlayer::prevMedia()
{
    if (!shuffle)
        playList.previous();
    else playList.setCurrentIndex(rand() % playList.mediaCount());
}

bool MusicPlayer::isShuffle()
{
    return shuffle;
}

void MusicPlayer::setShuffle(bool shuffle)
{
    this->shuffle = shuffle;
}

void MusicPlayer::setLoop(bool value)
{
    if (value) playList.setPlaybackMode(QMediaPlaylist::CurrentItemInLoop);
    else playList.setPlaybackMode(QMediaPlaylist::Loop);
}


void MusicPlayer::receivePlay(int index, const MusicItem &item)
{
    musicInfo = item;
    play(index);
}

void MusicPlayer::receivePlayList(const QVector<MusicItem> &list)
{
    playList.clear();
    for (int i = 0; i < list.size(); ++i) {
        playList.addMedia(QUrl::fromLocalFile(list.at(i).getUrl()));
    }
    playList.setCurrentIndex(0);
    playList.setPlaybackMode(QMediaPlaylist::Loop);
    player.setPlaylist(&playList);
    connect(&player, SIGNAL(mediaStatusChanged(QMediaPlayer::MediaStatus)), this, SLOT(updateCurrentMediaInfo(QMediaPlayer::MediaStatus)));
    connect(&player, &QMediaPlayer::positionChanged, this, [=](qint64 p){
        duration = p / 1000;
        emit updateDuration();
    });
}

void MusicPlayer::updateCurrentMediaInfo(QMediaPlayer::MediaStatus state)
{
    if (state == QMediaPlayer::MediaStatus::LoadingMedia){
        emit musicInfoSignal(playList.currentIndex());
    }
}

void MusicPlayer::receiveMediaInfo(const MusicItem &item)
{
    musicInfo = item;
    emit updateInfoSuccess();

}

QString MusicPlayer::timeToString(int time)
{
    int m = time / 60;
    int s = time % 60;
    return QString::number(m) + ":" + (s < 10 ? ("0" + QString::number(s)) : QString::number(s));
}

