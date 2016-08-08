.pragma library


function getWidth() {
    return 150//originalImage.paintedWidth
}

function getHeight() {
    return 100//originalImage.paintedHeight
}

function calculateScale(width, height, cellSize) {
    var widthScale = (cellSize * 1.0) / width
    var heightScale = (cellSize * 1.0) / height
    var scale = 0

    if (widthScale <= heightScale) {
        scale = widthScale;
    } else if (heightScale < widthScale) {
        scale = heightScale;
    }
    return scale;
}
