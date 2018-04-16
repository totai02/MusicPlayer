#ifndef ALBUMMODEL_H
#define ALBUMMODEL_H

#include <QAbstractListModel>
#include "controller/albumlist.h"

class AlbumModel : public QAbstractListModel
{
    Q_OBJECT

public:
    explicit AlbumModel(QObject *parent = nullptr);

    enum {
        ALBUM_ROLE = Qt::UserRole,
        ARTIST_ROLE
    };

    // Basic functionality:
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    QHash<int, QByteArray> roleNames() const override;


    AlbumList *list() const;
    void setList(AlbumList *list);

private:

    static QHash<int, QByteArray> mRoleName;

    AlbumList *mList;

};

#endif // ALBUMMODEL_H
