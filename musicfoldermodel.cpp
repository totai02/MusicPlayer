#include "musicfoldermodel.h"

MusicFolderModel::MusicFolderModel(QObject *parent)
    : QAbstractListModel(parent)
    , mList(nullptr)
{

}

int MusicFolderModel::rowCount(const QModelIndex &parent) const
{
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
