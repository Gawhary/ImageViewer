#include "devicesmodel.h"



DevicesModel::DevicesModel(QObject *parent) :
    QAbstractListModel(parent)
{
//    qDebug() << "DevicesModel::DevicesModel";
    QHash<int, QByteArray> roles;
    roles[PathRole] = "fsPath";
    roles[NameRole] = "name";
    roles[IsFolderRole] = "isFolder";//dummy role, always true
    setRoleNames(roles);
}

QVariant DevicesModel::data(const QModelIndex &index, int role) const
{

    if (index.row() < 0 || index.row() >= count())  return QVariant();
    QString path = m_deviceList[index.row()].filePath();

    switch (role) {
    case PathRole:
        return path;
    case NameRole:
        return QDir(path).dirName();
    case IsFolderRole:
        return true;
    default:
        return QVariant();
    }
}

int DevicesModel::rowCount(const QModelIndex &parent) const
{
//    qDebug() << "DevicesModel::rowCount called";
    return m_deviceList.count();
}

int DevicesModel::count() const
{
    return rowCount();
}


QObject *DevicesModel::get(int index)
{
//    qDebug() << "DevicesModel::get just called, index: " << index;
//    qDebug() << "count: " << count();
    if (index < 0 || index >= count()) return 0;
    return new Device(m_deviceList[index].filePath(), this);
}
