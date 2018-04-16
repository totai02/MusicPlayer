#ifndef ARTISTINFO_H
#define ARTISTINFO_H

#include <QObject>
#include <QHash>
#include <QVector>

#include "define/defines.h"
#include "entity/musicitem.h"

class ArtistInfo : public QObject
{
    Q_OBJECT
public:
    explicit ArtistInfo(QObject *parent = nullptr);

signals:

    void readyResult(const HashCharString &);

public slots:

    void onUpdateArtists(const MusicItemVector &list);
};

#endif // ARTISTINFO_H
