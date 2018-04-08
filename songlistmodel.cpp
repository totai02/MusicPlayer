#include "songlistmodel.h"

SongListModel::SongListModel(QObject *parent)
    : QAbstractListModel(parent)
{
    for(int i = 0; i < 10000; i++){
        QString title("See You Again ");
        title += QString::number(i);
        QString artist("Wiz Khalifa, Charlie Puth");
        QString album("Furious 7 OST");
        QString genre("Contemporary POP");
        int length = 245;

        mList.append({title, artist, album, genre, length});
    }
}

int SongListModel::rowCount(const QModelIndex &parent) const
{
    // For list models only the root node (an invalid parent) should return the list's size. For all
    // other (valid) parents, rowCount() should return 0 so that it does not become a tree model.
    if (parent.isValid())
        return 0;

    return mList.size();
}

QVariant SongListModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    const SongItem item = mList.at(index.row());

    switch (role){
        case TitleRole:
            return QVariant(item.title);
        case ArtistRole:
            return QVariant(item.artist);
        case AlbumRole:
            return QVariant(item.album);
        case GenreRole:
            return QVariant(item.genre);
        case LengthRole:
            return QVariant(item.length);
    }


    return QVariant();
}

bool SongListModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if (data(index, role) != value) {
        // FIXME: Implement me!
        emit dataChanged(index, index, QVector<int>() << role);
        return true;
    }
    return false;
}

Qt::ItemFlags SongListModel::flags(const QModelIndex &index) const
{
    if (!index.isValid())
        return Qt::NoItemFlags;

    return Qt::ItemIsEditable; // FIXME: Implement me!
}

QHash<int, QByteArray> SongListModel::roleNames() const
{
    QHash<int, QByteArray> names;
    names[TitleRole] = "title";
    names[ArtistRole] = "artist";
    names[AlbumRole] = "album";
    names[GenreRole] = "genre";
    names[LengthRole] = "length";

    return names;
}
