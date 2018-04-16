#ifndef ARTISTMODEL_H
#define ARTISTMODEL_H

#include <QAbstractListModel>
#include "controller/artistlist.h"

class ArtistModel : public QAbstractListModel
{
    Q_OBJECT

public:
    explicit ArtistModel(QObject *parent = nullptr);

    enum {
        GROUPNAME_ROLE = Qt::UserRole,
        ARTISTLIST_ROLE
    };

    // Basic functionality:
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    QHash<int, QByteArray> roleNames() const override;

    ArtistList *list() const;
    void setList(ArtistList *list);

private:

    static QHash<int, QByteArray> mRoleName;

    ArtistList *mList;
};

#endif // ARTISTMODEL_H
