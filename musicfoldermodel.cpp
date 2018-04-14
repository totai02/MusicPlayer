#include "musicfoldermodel.h"

MusicFolderModel::MusicFolderModel(QObject *parent)
    : QAbstractListModel(parent)
    , mList(nullptr)
{

}

int MusicFolderModel::rowCount(const QModelIndex &parent) const
{
    // For list models only the root node (an invalid parent) should return the list's size. For all
    // other (valid) parents, rowCount() should return 0 so that it does not become a tree model.
    if (parent.isValid())
        return 0;

    return mList->items().size();
}

QVariant MusicFolderModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    FolderItem item = mList->items().at(index.row());

    switch (role){
    case NAME_ROLE:
        return QVariant(item.getName());
    case URL_ROLE:
        return QVariant(item.getUrl());
    }

    return QVariant();
}

bool MusicFolderModel::setData(const QModelIndex &index, const QVariant &value, int role)
{
    if (data(index, role) != value) {
        // FIXME: Implement me!
        emit dataChanged(index, index, QVector<int>() << role);
        return true;
    }
    return false;
}

Qt::ItemFlags MusicFolderModel::flags(const QModelIndex &index) const
{
    if (!index.isValid())
        return Qt::NoItemFlags;

    return Qt::ItemIsEditable; // FIXME: Implement me!
}

QHash<int, QByteArray> MusicFolderModel::mRoleName = {
    {(int) NAME_ROLE, "name"},
    {(int) URL_ROLE, "url"}
};

QHash<int, QByteArray> MusicFolderModel::roleNames() const
{
    return mRoleName;
}

MusicFolderList *MusicFolderModel::getList() const
{
    return mList;
}

void MusicFolderModel::setList(MusicFolderList *value)
{
    beginResetModel();

    if (mList){
        mList->disconnect();
    }

    mList = value;

    if (mList){
        QObject::connect(mList, &MusicFolderList::preAppendItem, this, [=](){
            const int index = mList->items().size();
            beginInsertRows(QModelIndex(), index, index);
        });

        QObject::connect(mList,  &MusicFolderList::postAppendItem, this, [=](){
            endInsertRows();
        });

        QObject::connect(mList, &MusicFolderList::preRemoveItem, this, [=](int index){
            beginRemoveRows(QModelIndex(), index, index);
        });

        QObject::connect(mList,  &MusicFolderList::postRemoveItem, this, [=](){
            endRemoveRows();
        });
    }
}
