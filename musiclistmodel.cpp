#include "musiclistmodel.h"
#include <QDebug>

MusicListModel::MusicListModel(QObject *parent)
    : QAbstractListModel(parent)
    , mList(nullptr)
{
}

int MusicListModel::rowCount(const QModelIndex &parent) const
{
    if (!mList || parent.isValid())
        return 0;
    return mList->items().size();
}

QVariant MusicListModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid() || !mList)
        return QVariant();

    const MusicItem item = mList->items().at(index.row());

    switch (role){
    case URL_ROLE:
        return QVariant(item.getUrl());
    case TITLE_ROLE:
        return QVariant(item.getTitle());
    case ARTIST_ROLE:
        return QVariant(item.getArtist());
    case ALBUM_ROLE:
        return QVariant(item.getAlbum());
    case GENRE_ROLE:
        return QVariant(item.getGenre());
    case LENGTH_ROLE:
        return QVariant(item.getLength());
    }

    return QVariant();
}

bool MusicListModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if (data(index, role) != value) {
        // FIXME: Implement me!
        emit dataChanged(index, index, QVector<int>() << role);
        return true;
    }
    return false;
}

Qt::ItemFlags MusicListModel::flags(const QModelIndex &index) const
{
    if (!index.isValid())
        return Qt::NoItemFlags;

    return Qt::ItemIsEditable; // FIXME: Implement me!
}

QHash<int, QByteArray> MusicListModel::mRoleName = {
    {(int) URL_ROLE, "url"},
    {(int) TITLE_ROLE, "title"},
    {(int) ARTIST_ROLE, "artist"},
    {(int) ALBUM_ROLE, "album"},
    {(int) GENRE_ROLE, "genre"},
    {(int) LENGTH_ROLE, "length"},
};

QHash<int, QByteArray> MusicListModel::roleNames() const
{
    return mRoleName;
}

MusicList *MusicListModel::list() const
{
    return mList;
}

void MusicListModel::setList(MusicList *list)
{
    beginResetModel();

    if (mList){
        mList->disconnect();
    }

    mList = list;

    if (mList){
        QObject::connect(mList, &MusicList::preAppendItem, this, [=](){
            const int index = mList->items().size();
            beginInsertRows(QModelIndex(), index, index);
        });

        QObject::connect(mList,  &MusicList::postAppendItem, this, [=](){
            endInsertRows();
        });

        QObject::connect(mList, &MusicList::preRemoveAllItem, this, [=](){
            beginResetModel();
        });

        QObject::connect(mList, &MusicList::postRemoveAllItem, this, [=](){
            endResetModel();
        });
    }
    endResetModel();
}
