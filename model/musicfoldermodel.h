#ifndef MUSICFOLDERMODEL_H
#define MUSICFOLDERMODEL_H

#include <QAbstractListModel>
#include <QVector>

#include "controller/musicfolderlist.h"

class MusicFolderModel : public QAbstractListModel
{
    Q_OBJECT

public:
    explicit MusicFolderModel(QObject *parent = nullptr);

    enum {
        NAME_ROLE = Qt::UserRole,
        URL_ROLE
    };

    // Basic functionality:
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    QHash<int, QByteArray> roleNames() const override;

    MusicFolderList *getList() const;
    void setList(MusicFolderList *value);

private:

    static QHash<int, QByteArray> mRoleName;

    MusicFolderList *mList;
};

#endif // MUSICFOLDERMODEL_H
