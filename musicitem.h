#ifndef MUSICITEM_H
#define MUSICITEM_H
#include <QString>

class MusicItem
{
public:
    MusicItem();

    QString getUrl() const;
    void setUrl(const QString &value);

    QString getTitle() const;
    void setTitle(const QString &value);

    QString getArtist() const;
    void setArtist(const QString &value);

    QString getAlbum() const;
    void setAlbum(const QString &value);

    QString getGenre() const;
    void setGenre(const QString &value);

    int getLength() const;
    void setLength(int value);

private:
    QString url;
    QString title;
    QString artist;
    QString album;
    QString genre;
    int length;
};

#endif // MUSICITEM_H
