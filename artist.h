#ifndef ARTIST_H
#define ARTIST_H

#include <QAbstractListModel>

class Artist : public QAbstractListModel
{
    Q_OBJECT

public:
    explicit Artist(QObject *parent = nullptr);

    // Header:
    QVariant headerData(int section, Qt::Orientation orientation, int role = Qt::DisplayRole) const override;

    // Basic functionality:
    int rowCount(const QModelIndex &parent = QModelIndex()) const override;

    QVariant data(const QModelIndex &index, int role = Qt::DisplayRole) const override;

private:
};

#endif // ARTIST_H