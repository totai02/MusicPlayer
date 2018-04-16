#ifndef ARTISTLIST_H
#define ARTISTLIST_H

#include <QObject>
#include <QVector>
#include <QHash>
#include <QThread>

#include "define/defines.h"

#include "entity/artistitem.h"
#include "entity/musicitem.h"
#include "tool/artistinfo.h"

class ArtistList : public QObject
{
    Q_OBJECT
public:
    explicit ArtistList(QObject *parent = nullptr);

    ~ArtistList(){
        thread.quit();
        thread.wait();
    }

    QVector<ArtistItem> items() const;

    void setTool(ArtistInfo *tool);

signals:

    void updateArtists(const MusicItemVector &list);

    void preItemAppended();
    void postItemAppended();

    void preItemClear();
    void postItemClear();

public slots:

    void onReceiveMediaList(const QVector<MusicItem> &list);

    void onReceiveArtists(const HashCharString &hash);

private:

    QVector<ArtistItem> mList;

    QThread thread;

};

#endif // ARTISTLIST_H
