#ifndef ALBUMITEM_H
#define ALBUMITEM_H
#include <QString>

class AlbumItem
{
public:
    AlbumItem();

    QString getAlbumName() const;
    void setAlbumName(const QString &value);

    QString getArtistName() const;
    void setArtistName(const QString &value);

private:

    QString albumName;
    QString artistName;

};

#endif // ALBUMITEM_H
