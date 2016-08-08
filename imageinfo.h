#ifndef IMAGEINFO_H
#define IMAGEINFO_H

#include <QObject>
#include <QImageReader>
#include <QUrl>

class ImageInfo : public QObject
{
    Q_OBJECT
    Q_PROPERTY(QUrl source READ source WRITE setSource NOTIFY sourceChanged)
    Q_PROPERTY(QSize imageSize READ imageSize NOTIFY imageSizeChanged)
    Q_PROPERTY(double aspectRatio READ aspectRatio NOTIFY aspectRatioChanged)
    Q_PROPERTY(bool isWide READ isWide NOTIFY isWideChanged)

    QImageReader m_imageReader;
    QSize m_imageSize;

    QUrl m_source;

    double m_aspectRatio;

    bool m_isWide;

public:
    explicit ImageInfo(QObject *parent = 0);

QUrl source() const
{
//    return QUrl::fromLocalFile(m_source);
    return m_source;
}


QSize imageSize() const
{
    return m_imageSize;
}

double aspectRatio() const
{
    return m_aspectRatio;
}

bool isWide() const
{
    return m_isWide;
}

signals:
void imageSizeChanged(QSize arg);

void sourceChanged(QUrl arg);

void aspectRatioChanged(double arg);

void isWideChanged(bool arg);

public slots:

QSize imageSizeToFitInRec(int width, int height);


void setSource(QUrl arg)
{
    if(arg != m_source){
        m_imageReader.setFileName(arg.toLocalFile());
        m_imageSize = m_imageReader.size();
        m_source = arg;
        double newRatio = ((double)m_imageSize.width()) / ((double) m_imageSize.height());
        if(newRatio != m_aspectRatio){
            m_aspectRatio = newRatio;
            emit aspectRatioChanged(m_aspectRatio);
            if((m_aspectRatio > 1 ) != m_isWide ){
                m_isWide ^= 1;
                emit isWideChanged(m_isWide);
            }
        }
        emit sourceChanged(m_source);
        emit imageSizeChanged(m_imageSize);
    }
}

};

#endif // IMAGEINFO_H
