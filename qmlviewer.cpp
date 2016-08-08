

#include "qmlviewer.h"
#include <QGraphicsObject>
#include <QDeclarativeEngine>
#include <QDeclarativeComponent>
#include <QVariantMap>
#include <QVariant>
#include <QSignalMapper>

#include <QDebug>

//#include "libqxt/src/gui/qxtglobalshortcut.h"

//#ifdef KeyPress
//    const int XKeyPress = KeyPress;
//    const int XKeyRelease = KeyRelease;
//    #undef KeyPress
//    #undef KeyRelease
//#endif

QObject* QMLViewer::g_settings = NULL;

QMLViewer::QMLViewer(QWidget *parent) :
    QmlApplicationViewer(parent),
    m_opacityEffect(new QGraphicsOpacityEffect(this)),
    m_opacity(1)

{

//    QWidget::setWindowOpacity(1);
    /* you need both these lines for a transparent main window */
    this->setAttribute(Qt::WA_TranslucentBackground);
    this->setStyleSheet("background:transparent;");

    /* turn off window decorations and make it always on top*/


//    Qt::WindowFlags flags = this->windowFlags();
     QDeclarativeContext* context = this->rootContext();
//    this->setResizeMode(QDeclarativeView::SizeRootObjectToView);
    const QRect screenGeometry = QApplication::desktop()->screenGeometry();
    setResizeMode(QMLViewer::SizeRootObjectToView);


//    this->setGeometry(screenGeometry);
    context->setContextProperty("screenWidth", screenGeometry.width());
    context->setContextProperty("screenHeight", screenGeometry.height());
    context->setContextProperty("services", new Services(this));
    context->setContextProperty("viewer", this);


//    QDeclarativeComponent component(engine());
//    QDeclarativeItem *item = qobject_cast<QDeclarativeItem *>(component.create());


//#ifdef Q_WS_X11

//    m_keyCode = XKeysymToKeycode(QX11Info::display(), XK_F1);
//    XGrabKey(QX11Info::display(), m_keyCode, ControlMask|ShiftMask, QX11Info::appRootWindow(), False, GrabModeAsync, GrabModeAsync);
//    XFlush(QX11Info::display());

//#endif
//    qApp->installEventFilter(this);

//    connect(this, SIGNAL(statusChanged(QDeclarativeView::Status)),this, SLOT(onStatusChanges(QDeclarativeView::Status)));
    connect(qApp, SIGNAL(focusChanged(QWidget*,QWidget*)), this, SLOT(onFocusChanged(QWidget*,QWidget*)));



}

QMLViewer::~QMLViewer()
{
#ifdef Q_WS_X11
//    XUngrabKey(QX11Info::display(), m_keyCode, ControlMask|ShiftMask, QX11Info::appRootWindow());
#endif
}

QObject* QMLViewer::settings()
{
    return g_settings;
}

QGraphicsObject *QMLViewer::root() const
{
    return this->rootObject();
}

qreal QMLViewer::opacity() const
{
    return m_opacity;
}

bool QMLViewer::focus() const
{
    return QWidget::hasFocus();
}

//void QMLViewer::installHotKeys()
//{

//    if(!g_settings)
//        return;

//    QVariantMap hotKeysProperty = g_settings->property("hotKeys").toMap();
//    if(hotKeysProperty.isEmpty())
//        return;

//    QSignalMapper *signalMapper = new QSignalMapper(this);
//    connect(signalMapper, SIGNAL(mapped(const QString &)),
//            this, SIGNAL(hotKeyPressed(const QString &)));

//    QxtGlobalShortcut* shortcut;
//    foreach (const QString &key, hotKeysProperty.keys()) {
//        QKeySequence keyCode(hotKeysProperty[key].toInt());
//        if(keyCode.isEmpty())
//            continue;
//        shortcut = new QxtGlobalShortcut(this);
//        connect(shortcut, SIGNAL(activated()), signalMapper, SLOT(map()));
//        signalMapper->setMapping(shortcut, key);
//        shortcut->setShortcut(keyCode);
//    }


//}

//void QMLViewer::onStatusChanges(QDeclarativeView::Status status)
//{
//    if(QDeclarativeView::Ready == status){
//        g_settings =  this->rootObject()->findChild<QObject*>("settings");
//        installHotKeys();
    //    }
//}

void QMLViewer::onFocusChanged(QWidget * old, QWidget * now)
{
    if(old == this){
        emit focusChanged(false);
        return;
    }
    if(now == this)
        emit focusChanged(true);
}



void QMLViewer::activateWindow()
{
    QWidget::activateWindow();
}

void QMLViewer::setFocus(bool focus)
{
    if(focus)
        QmlApplicationViewer::setFocus();
    else
        QmlApplicationViewer::clearFocus();

}

void QMLViewer::setOpacity(qreal arg)
{
//        qDebug() << "setWindowOpacity called with arg = " << arg;
    if (m_opacity != arg) {
        m_opacity = arg;
//            QWidget::setWindowOpacity(arg);//works only for top level widgets
//            QString stylesheet("background-color: rgba(0,200,0," + QString::number(m_opacity) + ");");//works only for top level widgets
//            setStyleSheet(stylesheet);
        m_opacityEffect->setOpacity(arg);
        setGraphicsEffect(m_opacityEffect);
        emit opacityChanged(arg);
    }
}


//bool QMLViewer::event(QEvent *e)
//{
//    static int counter = 0;
//    qDebug()  << ++counter << "QMLViewer::event: event type" << e->type();
//    return QmlApplicationViewer::event(e);
//}

//void QMLViewer::deActivateWindow()
//{
//    qApp->setActiveWindow(0);
//}


//bool QMLViewer::eventFilter(QObject *watched, QEvent *event)
//{
//    if(event->type() == QEvent::KeyPress) {
//        QKeyEvent *keyEvent = static_cast<QKeyEvent*>(event);
//        int qtKey = keyEvent->key();
//        qDebug() << "key: " << qtKey << " pressed.";
//        if(qtKey == Qt::Key_F1)
//            emit menuKeyPressed();
//    }
//    return false;
//}
