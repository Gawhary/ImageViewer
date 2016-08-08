#include "imageinfo.h"

ImageInfo::ImageInfo(QObject *parent) :
    QObject(parent)
{
    m_aspectRatio = 1;
    m_isWide  = (true);
    m_imageSize = QSize(0,0);
}

QSize ImageInfo::imageSizeToFitInRec(int width, int height)
{
    if(m_isWide)
        return QSize(width, width / m_aspectRatio);
    else
        return QSize(m_aspectRatio * height, height);
}
