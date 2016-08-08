#include "services.h"
#include <QDebug>
#include <QFile>
#include <QUrl>
//#include <QNetworkRequest>
//#include <QNetworkReply>
#include <QByteArray>


Services::Services(QObject *parent) :
    QObject(parent)
  ,m_process(NULL)
//  ,m_networkAccessmanager(NULL)
{
#ifdef Q_OS_WIN
    m_systemIsWindows = true;
    qDebug() << "System is Windows";
#else
    m_systemIsWindows = false;
#endif
}

bool Services::systemIsWindows() const
{
    return m_systemIsWindows;
}

void Services::initProcess()
{
    m_process = new QProcess(this);
    connect(m_process, SIGNAL(readyReadStandardOutput()), this, SLOT(readyReadStandardOutput()));
    connect(m_process, SIGNAL(readyReadStandardError()), this, SLOT(readyReadStandardError()));
    connect(m_process, SIGNAL(started()), this, SLOT(launchedApplicationStarted()));
    connect(m_process, SIGNAL(error(QProcess::ProcessError)), this, SLOT(launchedApplicationError(QProcess::ProcessError)));

}


void Services::launchApplication(QString url, QStringList args)
{
    if(url.isEmpty() || url.isNull())
        return;
    qDebug() << "Services::launchApplication CALLED, URL:" << url << ", args: " << args;
    if(m_process)
        this->closeLaunchedApplication();
    initProcess();
    m_process->start(url, args, QIODevice::ReadWrite);

}

QString Services::readTextFile(QString filePath)
{
    qDebug() << "readTextFile called with filePath: " << filePath;
    QFile file(filePath);
    file.open(QIODevice::ReadOnly);
    if(!file.isOpen())
        qDebug() << "Can't open file to read";
    QString data = file.readAll();
    file.close();
//    qDebug() << "file content:  " << data;
    return data;

}

QString Services::executeCommand(QString url, QStringList args)
{
    if(url.isEmpty() || url.isNull())
        return "";
    qDebug() << "Services::executeCommand CALLED, URL:" << url;
    QProcess process;
    process.start(url, args, QIODevice::ReadWrite);
    process.waitForFinished(-1);
    QString output = process.readAll();
    qDebug() << "Services::executeCommand(), output: " << output;
    return output.trimmed();
}

void Services::readyReadStandardOutput()
{
    QString out = m_process->readAllStandardOutput();
    qDebug() << "Services::readyReadStandardOutput(), output: " << out;
    emit applicationOutRecieved(out.trimmed());
}

void Services::readyReadStandardError()
{
    QString out = m_process->readAllStandardError();
    qDebug() << "Services::readyReadStandardError(), error: " << out;
    emit applicationErrorRecieved(out.trimmed());
}

void Services::launchedApplicationStarted()
{
    qDebug() << "Application started";
}

void Services::launchedApplicationError(QProcess::ProcessError error)
{
    qDebug() << "application Error, error code: " << error;
}

void Services::closeLaunchedApplication()
{
    if(m_process){
        m_process->close();
        m_process->deleteLater();
        m_process = NULL;
    }
}

//void Services::featchWebContent(QString url)
//{
//    if(!m_networkAccessmanager){
//        m_networkAccessmanager = new QNetworkAccessManager(this);

//        connect(m_networkAccessmanager, SIGNAL(finished(QNetworkReply*)),
//             this, SLOT(replyFinished(QNetworkReply*)));
//    }

//    m_networkAccessmanager->get(QNetworkRequest(QUrl(url)));

//}

//void Services::replyFinished(QNetworkReply *pReply)
//{

//    QByteArray data=pReply->readAll();
//    QString str(data);
//    emit webContentFeatched(str);
//}


