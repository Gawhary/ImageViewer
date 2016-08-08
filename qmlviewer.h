#ifndef QMLVIEWER_H
#define QMLVIEWER_H


#include <qmlapplicationviewer.h>

#include <QApplication>
#include <QDesktopWidget>
#include <QDeclarativeContext>
#include <QApplication>
#include <QEvent>
#include <QKeyEvent>
#include <QDebug>
#include <QGraphicsObject>
#include <QGraphicsOpacityEffect>

#include "services.h"

#include <QDebug>

//#ifdef Q_WS_X11
//    #include <X11/X.h>
//    #include <X11/Xlib.h>
//    #include <QX11Info>
//    #include <X11/keysym.h>
//#endif

//#define DEFAULT_MENU_KEY "F1"
//#define DEFAULT_MEDIA_CONTROLLER_KEY "F1"

class QMLViewer : public QmlApplicationViewer
{
    Q_OBJECT
    Q_PROPERTY(QGraphicsObject* root READ root NOTIFY rootChanged)
    Q_PROPERTY(qreal opacity READ opacity WRITE setOpacity NOTIFY opacityChanged)
    Q_PROPERTY(bool focus READ focus WRITE setFocus NOTIFY focusChanged)
public:
    explicit QMLViewer(QWidget *parent = 0);

    ~QMLViewer();

    static QObject* settings();

    //    bool eventFilter(QObject *watched, QEvent *e);


    QGraphicsObject* root() const;

    qreal opacity() const;

    bool focus() const;

private:
//    KeyCode m_keyCode;
//    void installHotKeys();
    
signals:
    void hotKeyPressed(const QString& key);

    void rootChanged(QGraphicsObject* arg);//not used only to prevent qml error

    void opacityChanged(qreal arg);

    void focusChanged(bool arg);

private slots:
//    void onStatusChanges(QDeclarativeView::Status);
    void onFocusChanged(QWidget *old, QWidget *now);

public slots:
    void activateWindow();
    //    void deActivateWindow();
    void setFocus(bool focus);


    void setOpacity(qreal arg);

protected:
//    virtual bool  event(QEvent *);
private:
    static QObject* g_settings;
    QGraphicsOpacityEffect * m_opacityEffect;


    qreal m_opacity;
};
#endif // QMLVIEWER_H
