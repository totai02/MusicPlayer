#include "musicfolderlist.h"

MusicFolderList::MusicFolderList(QObject *parent) : QObject(parent)
{

}

void MusicFolderList::getFolderList()
{
    emit sendFolderList(mList);
}

QVector<FolderItem> MusicFolderList::items() const
{
    return mList;
}

void MusicFolderList::append(QString url, bool addFile)
{
    if (url.contains("file:///")) url = url.remove(0, 8);
    QString name("");
    for (int i = url.length() - 1; i >= 0; --i) {
        if (url.at(i) == "/" || url.at(i) == "\\"){
            break;
        }
        name.prepend(url.at(i));
    }

    emit preAppendItem();
    FolderItem item;
    item.setName(name);
    item.setUrl(url);
    mList.append(item);
    emit postAppendItem();

    if (addFile){
        writeDataToFile();
    }

    emit sendFolderList(mList);
}

void MusicFolderList::removeRow(int index)
{
    emit preRemoveItem(index);
    mList.remove(index);
    emit postRemoveItem();

    writeDataToFile();

    emit sendFolderList(mList);
}

void MusicFolderList::removeAll()
{
    for (int i = 0; i < mList.size(); ++i) {
        emit preRemoveItem(i);
        mList.remove(i);
        emit postRemoveItem();
    }
}

void MusicFolderList::readDataFromFile()
{
    QFile file("userdata.dat");

    if (!file.open(QIODevice::ReadOnly | QIODevice::Text))
    return;

    QTextStream in(&file);
    while (!in.atEnd()) {
       QString line = in.readLine();
       append(line, false);
    }
    file.close();
}

void MusicFolderList::writeDataToFile()
{
    QFile file("userdata.dat");
    if (!file.open(QIODevice::WriteOnly | QIODevice::Text))
        return;

    QTextStream out(&file);

    for (int i = 0; i < mList.size(); ++i) {
        out << mList.at(i).getUrl() << "\n";
    }
    file.close();
}
