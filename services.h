#ifndef SERVICES_H
#define SERVICES_H

#include <QObject>
#include <QProcess>
#include <QStringList>
//#include <QNetworkAccessManager>

class Services : public QObject
{
    Q_OBJECT
    Q_PROPERTY(bool systemIsWindows READ systemIsWindows NOTIFY systemIsWindowsChanged)
public:

    explicit Services(QObject *parent = 0);



    bool systemIsWindows() const;

private:
    void initProcess();
    
signals:
    void applicationOutRecieved(QString output);
    void applicationErrorRecieved(QString output);


    void systemIsWindowsChanged(bool arg);
    void webContentFeatched(QString content);

public slots:
    void launchApplication(QString url, QStringList args = QStringList());
    QString readTextFile(QString filePath);
    QString executeCommand(QString url, QStringList args);
    void readyReadStandardOutput();
    void readyReadStandardError();
    void launchedApplicationStarted();
    void launchedApplicationError(QProcess::ProcessError);
    void closeLaunchedApplication();
//    void featchWebContent(QString url);
//    void replyFinished(QNetworkReply*);


    
private:
    QProcess* m_process;
    bool m_systemIsWindows;
//    QNetworkAccessManager* m_networkAccessmanager;
};

#endif // SERVICES_H
