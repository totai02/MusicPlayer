#ifndef ARTISTITEM_H
#define ARTISTITEM_H

#include <QVector>

class ArtistItem
{
public:
    ArtistItem();

    QList<QString> getArtistList() const;
    void setArtistList(const QList<QString> &value);

    QChar getGroupName() const;
    void setGroupName(const QChar &value);

private:
    QChar groupName;
    QList<QString> artistList;
};

#endif // ARTISTITEM_H
