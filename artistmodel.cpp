#include "artistmodel.h"

ArtistModel::ArtistModel(QObject *parent)
    : QAbstractListModel(parent)
    , mList(nullptr)
{
}

int ArtistModel::rowCount(const QModelIndex &parent) const
{
    if (parent.isValid())
        return 0;

    return mList->items().size();
}

QVariant ArtistModel::data(const QModelIndex &index, int role) const
{
    if (!index.isValid())
        return QVariant();

    const ArtistItem item = mList->items().at(index.row());

    switch (role){
    case GROUPNAME_ROLE:
        return QVariant(item.getGroupName());
    case ARTISTLIST_ROLE:
        return QVariant(item.getArtistList());
    }

    return QVariant();
}

QHash<int, QByteArray> ArtistModel::mRoleName = {
    {(int) GROUPNAME_ROLE, "groupName"},
    {(int) ARTISTLIST_ROLE, "artistList"}
};

QHash<int, QByteArray> ArtistModel::roleNames() const
{
    return mRoleName;
}

ArtistList *ArtistModel::list() const
{
    return mList;
}

void ArtistModel::setList(ArtistList *list)
{
    beginResetModel();

    if (mList){
        mList->disconnect();
    }

    mList = list;

    if (mList){
        QObject::connect(mList, &ArtistList::preItemAppended, this, [=](){
            const int index = mList->items().size();
            beginInsertRows(QModelIndex(), index, index);
        });

        QObject::connect(mList,  &ArtistList::postItemAppended, this, [=](){
            endInsertRows();
        });

        QObject::connect(mList, &ArtistList::preItemClear, this, [=](){
            beginResetModel();
        });

        QObject::connect(mList, &ArtistList::postItemClear, this, [=](){
            endResetModel();
        });
    }
    endResetModel();
}
