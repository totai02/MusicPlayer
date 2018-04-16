#ifndef DEFINES_H
#define DEFINES_H

#include <QVector>

#include "entity/musicitem.h"

typedef QVector<MusicItem> MusicItemVector;
typedef QHash<QChar,QList<QString> > HashCharString;

#endif // DEFINES_H
