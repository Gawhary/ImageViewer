#include <QtGui/QApplication>
#include <QFileSystemModel>

#include "qmlviewer.h"
#include "qdeclarativefolderlistmodel.h"
#include "imageinfo.h"
#include "devicesmodel.h"
//#include "devicesfolderlistmodel.h"


Q_DECL_EXPORT int main(int argc, char *argv[])
{
//    QScopedPointer<QApplication> app(createApplication(argc, argv));
    QApplication  *app = new QApplication(argc, argv);
//    IgApplication::Configuration *pConfig =  app->getConfiguration();
//    pConfig->applicationName = "mediaPlayer";
//    pConfig->applicationVersion = "";
//    pConfig->organizationName = "igee";
//    pConfig->organizationDomain = "igos.com";
//    //pConfig->notificationsManagerType = IgNotificationsManager::NOT_AVILABLE;
//    pConfig->ipcClientInterface = 0;
//    app->initialize();

    qmlRegisterType<QDeclarativeFolderListModel>("folderlistmodel", 1,0,"FolderListModel");
    qmlRegisterType<DevicesModel>("IGComponents", 1,0,"DevicesModel");
//    qmlRegisterType<DevicesFolderListModel>("folderlistmodel", 1,0,"DevicesFolderListModel");
    qmlRegisterType<ImageInfo>("IGComponents", 1,0,"ImageInfo");

    QMLViewer viewer;

//    DevicesModel dm;
//    viewer.rootContext()->setContextProperty("devicesModel", &dm);

    viewer.setOrientation(QmlApplicationViewer::ScreenOrientationAuto);
    viewer.setMainQmlFile(QLatin1String("qml/imageViewer/main.qml"));



    viewer.showExpanded();

    return app->exec();
}
