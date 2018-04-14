#ifndef FOLDERITEM_H
#define FOLDERITEM_H
#include <QString>

class FolderItem
{
public:
    FolderItem();
    QString getName() const;
    void setName(const QString &value);

    QString getUrl() const;
    void setUrl(const QString &value);

private:
    QString name;
    QString url;
};

#endif // FOLDERITEM_H
