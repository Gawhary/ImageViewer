/****************************************************************************
** Meta object code from reading C++ file 'devicesfolderlistmodel.h'
**
** Created: Tue Jan 8 23:13:30 2013
**      by: The Qt Meta Object Compiler version 63 (Qt 4.8.3)
**
** WARNING! All changes made in this file will be lost!
*****************************************************************************/

#include "devicesfolderlistmodel.h"
#if !defined(Q_MOC_OUTPUT_REVISION)
#error "The header file 'devicesfolderlistmodel.h' doesn't include <QObject>."
#elif Q_MOC_OUTPUT_REVISION != 63
#error "This file was generated using the moc from 4.8.3. It"
#error "cannot be used with the include files from this version of Qt."
#error "(The moc has changed too much.)"
#endif

QT_BEGIN_MOC_NAMESPACE
static const uint qt_meta_data_DevicesFolderListModel[] = {

 // content:
       6,       // revision
       0,       // classname
       0,    0, // classinfo
       6,   14, // methods
       7,   44, // properties
       0,    0, // enums/sets
       0,    0, // constructors
       0,       // flags
       1,       // signalCount

 // signals: signature, parameters, type, tag, flags
      24,   23,   23,   23, 0x05,

 // slots: signature, parameters, type, tag, flags
      40,   23,   23,   23, 0x0a,
      66,   50,   23,   23, 0x08,
      96,   50,   23,   23, 0x08,
     135,  125,   23,   23, 0x08,

 // methods: signature, parameters, type, tag, flags
     189,  183,  178,   23, 0x02,

 // properties: name, type, flags
     208,  203, 0x11495103,
     215,  203, 0x11495001,
     240,  228, 0x0b095103,
     252,  178, 0x01095103,
     261,  178, 0x01095103,
     278,  178, 0x01095103,
     299,  295, 0x02095001,

 // properties: notify_signal_id
       0,
       0,
       0,
       0,
       0,
       0,
       0,

       0        // eod
};

static const char qt_meta_stringdata_DevicesFolderListModel[] = {
    "DevicesFolderListModel\0\0folderChanged()\0"
    "refresh()\0index,start,end\0"
    "inserted(QModelIndex,int,int)\0"
    "removed(QModelIndex,int,int)\0start,end\0"
    "handleDataChanged(QModelIndex,QModelIndex)\0"
    "bool\0index\0isFolder(int)\0QUrl\0folder\0"
    "parentFolder\0QStringList\0nameFilters\0"
    "showDirs\0showDotAndDotDot\0showOnlyReadable\0"
    "int\0count\0"
};

void DevicesFolderListModel::qt_static_metacall(QObject *_o, QMetaObject::Call _c, int _id, void **_a)
{
    if (_c == QMetaObject::InvokeMetaMethod) {
        Q_ASSERT(staticMetaObject.cast(_o));
        DevicesFolderListModel *_t = static_cast<DevicesFolderListModel *>(_o);
        switch (_id) {
        case 0: _t->folderChanged(); break;
        case 1: _t->refresh(); break;
        case 2: _t->inserted((*reinterpret_cast< const QModelIndex(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3]))); break;
        case 3: _t->removed((*reinterpret_cast< const QModelIndex(*)>(_a[1])),(*reinterpret_cast< int(*)>(_a[2])),(*reinterpret_cast< int(*)>(_a[3]))); break;
        case 4: _t->handleDataChanged((*reinterpret_cast< const QModelIndex(*)>(_a[1])),(*reinterpret_cast< const QModelIndex(*)>(_a[2]))); break;
        case 5: { bool _r = _t->isFolder((*reinterpret_cast< int(*)>(_a[1])));
            if (_a[0]) *reinterpret_cast< bool*>(_a[0]) = _r; }  break;
        default: ;
        }
    }
}

const QMetaObjectExtraData DevicesFolderListModel::staticMetaObjectExtraData = {
    0,  qt_static_metacall 
};

const QMetaObject DevicesFolderListModel::staticMetaObject = {
    { &QAbstractListModel::staticMetaObject, qt_meta_stringdata_DevicesFolderListModel,
      qt_meta_data_DevicesFolderListModel, &staticMetaObjectExtraData }
};

#ifdef Q_NO_DATA_RELOCATION
const QMetaObject &DevicesFolderListModel::getStaticMetaObject() { return staticMetaObject; }
#endif //Q_NO_DATA_RELOCATION

const QMetaObject *DevicesFolderListModel::metaObject() const
{
    return QObject::d_ptr->metaObject ? QObject::d_ptr->metaObject : &staticMetaObject;
}

void *DevicesFolderListModel::qt_metacast(const char *_clname)
{
    if (!_clname) return 0;
    if (!strcmp(_clname, qt_meta_stringdata_DevicesFolderListModel))
        return static_cast<void*>(const_cast< DevicesFolderListModel*>(this));
    if (!strcmp(_clname, "QDeclarativeParserStatus"))
        return static_cast< QDeclarativeParserStatus*>(const_cast< DevicesFolderListModel*>(this));
    if (!strcmp(_clname, "com.trolltech.qml.QDeclarativeParserStatus"))
        return static_cast< QDeclarativeParserStatus*>(const_cast< DevicesFolderListModel*>(this));
    return QAbstractListModel::qt_metacast(_clname);
}

int DevicesFolderListModel::qt_metacall(QMetaObject::Call _c, int _id, void **_a)
{
    _id = QAbstractListModel::qt_metacall(_c, _id, _a);
    if (_id < 0)
        return _id;
    if (_c == QMetaObject::InvokeMetaMethod) {
        if (_id < 6)
            qt_static_metacall(this, _c, _id, _a);
        _id -= 6;
    }
#ifndef QT_NO_PROPERTIES
      else if (_c == QMetaObject::ReadProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: *reinterpret_cast< QUrl*>(_v) = folder(); break;
        case 1: *reinterpret_cast< QUrl*>(_v) = parentFolder(); break;
        case 2: *reinterpret_cast< QStringList*>(_v) = nameFilters(); break;
        case 3: *reinterpret_cast< bool*>(_v) = showDirs(); break;
        case 4: *reinterpret_cast< bool*>(_v) = showDotAndDotDot(); break;
        case 5: *reinterpret_cast< bool*>(_v) = showOnlyReadable(); break;
        case 6: *reinterpret_cast< int*>(_v) = count(); break;
        }
        _id -= 7;
    } else if (_c == QMetaObject::WriteProperty) {
        void *_v = _a[0];
        switch (_id) {
        case 0: setFolder(*reinterpret_cast< QUrl*>(_v)); break;
        case 2: setNameFilters(*reinterpret_cast< QStringList*>(_v)); break;
        case 3: setShowDirs(*reinterpret_cast< bool*>(_v)); break;
        case 4: setShowDotAndDotDot(*reinterpret_cast< bool*>(_v)); break;
        case 5: setShowOnlyReadable(*reinterpret_cast< bool*>(_v)); break;
        }
        _id -= 7;
    } else if (_c == QMetaObject::ResetProperty) {
        _id -= 7;
    } else if (_c == QMetaObject::QueryPropertyDesignable) {
        _id -= 7;
    } else if (_c == QMetaObject::QueryPropertyScriptable) {
        _id -= 7;
    } else if (_c == QMetaObject::QueryPropertyStored) {
        _id -= 7;
    } else if (_c == QMetaObject::QueryPropertyEditable) {
        _id -= 7;
    } else if (_c == QMetaObject::QueryPropertyUser) {
        _id -= 7;
    }
#endif // QT_NO_PROPERTIES
    return _id;
}

// SIGNAL 0
void DevicesFolderListModel::folderChanged()
{
    QMetaObject::activate(this, &staticMetaObject, 0, 0);
}
QT_END_MOC_NAMESPACE
