#include "albummodel.h"

AlbumModel::AlbumModel(QObject *parent)
    : QAbstractListModel(parent)
    , mList(nullptr)
{
}

int AlbumModel::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;

    return mList->items().size();
}

QVariant AlbumModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    const AlbumItem item = mList->items().at(index.row());

    switch (role){
    case ALBUM_ROLE:
        return QVariant(item.getAlbumName());
    case ARTIST_ROLE:
        return QVariant(item.getArtistName());
    }

    return QVariant();
}

QHash<int, QByteArray> AlbumModel::mRoleName = {
    {(int) ALBUM_ROLE, "album"},
    {(int) ARTIST_ROLE, "artist"}
};

QHash<int, QByteArray> AlbumModel::roleNames() const
{
    return mRoleName;
}

AlbumList *AlbumModel::list() const
{
    return mList;
}

void AlbumModel::setList(AlbumList *list)
{
    beginResetModel();

    if (mList){
        mList->disconnect();
    }

    mList = list;

    if (mList){
        QObject::connect(mList, &AlbumList::preItemAppended, this, [=](){
            const int index = mList->items().size();
            beginInsertRows(QModelIndex(), index, index);
        });

        QObject::connect(mList,  &AlbumList::postItemAppended, this, [=](){
            endInsertRows();
        });

        QObject::connect(mList, &AlbumList::preItemClear, this, [=](){
            beginResetModel();
        });

        QObject::connect(mList, &AlbumList::postItemClear, this, [=](){
            endResetModel();
        });
    }
    endResetModel();
}

