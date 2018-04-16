#ifndef ARTISTLIST_H
#define ARTISTLIST_H

#include <QObject>
#include <QVector>
#include <QHash>

#include "entity/artistitem.h"
#include "entity/musicitem.h"

class ArtistList : public QObject
{
    Q_OBJECT
public:
    explicit ArtistList(QObject *parent = nullptr);

    QVector<ArtistItem> items() const;

signals:

    void preItemAppended();
    void postItemAppended();

    void preItemClear();
    void postItemClear();

public slots:

    void onReceiveMediaList(const QVector<MusicItem> &list);

private:

    QVector<ArtistItem> mList;

};

#endif // ARTISTLIST_H
