#ifndef SONGLISTMODEL_H
#define SONGLISTMODEL_H

#include <QAbstractListModel>
#include <QVector>

struct SongItem{
    QString title;
    QString artist;
    QString album;
    QString genre;
    int length;
};

class SongListModel : public QAbstractListModel
{
    Q_OBJECT

public:
    explicit SongListModel(QObject *parent = nullptr);

    enum {
        TitleRole,
        ArtistRole,
        AlbumRole,
        GenreRole,
        LengthRole
    };

    // Basic functionality:
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

    // Editable:
    bool setData(const QModelIndex &index, const QVariant &value,
                 int role = Qt::EditRole) override;

    Qt::ItemFlags flags(const QModelIndex& index) const override;

    virtual QHash<int, QByteArray> roleNames() const override;

private:
    QVector<SongItem> mList;
};

#endif // SONGLISTMODEL_H
