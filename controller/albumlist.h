#ifndef ALBUMLIST_H
#define ALBUMLIST_H

#include <QObject>
#include <QVector>
#include <QHash>

#include "entity/albumitem.h"
#include "entity/musicitem.h"

class AlbumList : public QObject
{
    Q_OBJECT
public:
    explicit AlbumList(QObject *parent = nullptr);

    QVector<AlbumItem> items() const;

signals:

    void preItemAppended();
    void postItemAppended();

    void preItemClear();
    void postItemClear();

public slots:

    void onReceiveMediaList(const QVector<MusicItem> &list);

private:

    QVector<AlbumItem> mList;

};

#endif // ALBUMLIST_H
