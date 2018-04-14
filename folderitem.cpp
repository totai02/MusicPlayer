#include "folderitem.h"

FolderItem::FolderItem()
{

}

QString FolderItem::getName() const
{
    return name;
}

void FolderItem::setName(const QString &value)
{
    name = value;
}

QString FolderItem::getUrl() const
{
    return url;
}

void FolderItem::setUrl(const QString &value)
{
    url = value;
}
