#ifndef MUSICFOLDERCONTROLLER_H
#define MUSICFOLDERCONTROLLER_H

#include <QObject>
#include <QVector>
#include <QFile>
#include <QTextStream>

#include "entity/folderitem.h"

class MusicFolderList : public QObject
{
    Q_OBJECT
public:
    explicit MusicFolderList(QObject *parent = nullptr);

    QVector<FolderItem> items() const;

    Q_INVOKABLE void append(QString url, bool addFile = true);

    Q_INVOKABLE void removeRow(int index);

    Q_INVOKABLE void removeAll();

    void readDataFromFile();
    void writeDataToFile();

signals:
    void sendFolderList(const QVector<FolderItem> &list);

    void preAppendItem();
    void postAppendItem();
    void preRemoveItem(int);
    void postRemoveItem();

public slots:
    void getFolderList();

private:
    QVector<FolderItem> mList;
};

#endif // MUSICFOLDERCONTROLLER_H
