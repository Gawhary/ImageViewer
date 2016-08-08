#ifndef DEVICESMODEL_H
#define DEVICESMODEL_H

#include <QObject>
#include <QDebug>

#include <QAbstractListModel>
#include <QDir>

class Device : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QString fsPath READ fsPath NOTIFY fsPathChanged)
    Q_PROPERTY(QString name READ name NOTIFY nameChanged)
    Q_PROPERTY(bool isFolder READ isFolder NOTIFY isFolderChanged)

public:
    explicit Device(QString path, QObject* parent = 0) :
        QObject(parent)
    {
        m_path = path;
        m_name = QDir(path).dirName();
    }
    virtual ~Device() {}
    QString fsPath() const
    {
//        qDebug() << "Device::path() just called, path:" << m_path;
        return m_path;
    }
    QString name() const
    {
        return m_name;
    }

    bool isFolder() const
    {
        return true;
    }

private:
    QString m_path;
    QString m_name;

    bool m_isFolder;

signals:
void fsPathChanged(QString arg);
void nameChanged(QString arg);
void isFolderChanged(bool arg);
};

class DevicesModel : public QAbstractListModel
{
    Q_OBJECT
    Q_PROPERTY(int count  READ count  NOTIFY countChanged)
    Q_PROPERTY(QString mediaRoot READ mediaRoot WRITE setMediaRoot)
    int m_count;

    QString m_mediaRoot;
    QFileInfoList m_deviceList;

public:
    explicit DevicesModel(QObject *parent = 0);



    enum Roles { NameRole = Qt::UserRole+1, PathRole = Qt::UserRole+2, IsFolderRole = Qt::UserRole+3 };


    QVariant data(const QModelIndex & index, int role = Qt::DisplayRole) const;
    int rowCount( const QModelIndex & parent = QModelIndex()) const;


    
    int count() const;

    QString mediaRoot() const
    {
        return m_mediaRoot;
    }

signals:
    
    void countChanged(int arg);

public slots:
    QObject* get(int index);
    
    void setMediaRoot(QString arg)
    {
        m_mediaRoot = arg;
        QDir rootDir(m_mediaRoot);
        rootDir.setFilter(QDir::AllDirs | QDir::NoSymLinks | QDir::NoDotAndDotDot);
        m_deviceList = rootDir.entryInfoList();
    }
};

#endif // DEVICESMODEL_H
