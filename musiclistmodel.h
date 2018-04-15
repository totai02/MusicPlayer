#ifndef MUSICLISTMODEL_H
#define MUSICLISTMODEL_H

#include <QAbstractListModel>
#include <QVector>

#include "musicitem.h"
#include "musiclist.h"

class MusicList;

class MusicListModel : public QAbstractListModel
{
    Q_OBJECT

public:
    explicit MusicListModel(QObject *parent = nullptr);

    enum {
        URL_ROLE = Qt::UserRole,
        TITLE_ROLE,
        ARTIST_ROLE,
        ALBUM_ROLE,
        GENRE_ROLE,
        LENGTH_ROLE
    };

    // Basic functionality:
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    QHash<int, QByteArray> roleNames() const override;

    MusicList *list() const;
    void setList(MusicList *list);

public slots:

private:

    static QHash<int, QByteArray> mRoleName;

    MusicList *mList;
};

#endif // MUSICLISTMODEL_H
