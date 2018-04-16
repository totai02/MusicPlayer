#ifndef ALBUMINFO_H
#define ALBUMINFO_H

#include <QObject>

class albumInfo : public QObject
{
    Q_OBJECT
public:
    explicit albumInfo(QObject *parent = nullptr);

signals:

public slots:

    void onUpdateAlbums();
};

#endif // ALBUMINFO_H
