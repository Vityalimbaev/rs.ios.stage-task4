import Foundation

final class FillWithColor {
    
    func fillWithColor(_ image: [[Int]], _ row: Int, _ column: Int, _ newColor: Int) -> [[Int]] {
        let oldColor = (image.count == 0 || image[0].count == 0) ? 0 : image[row][column]
        
        var newImag = fillRecursion(image, row, column, newColor, oldColor)
        newImag[row][column] = newColor
        return  newImag }
    
    private func fillRecursion(_ image: [[Int]], _ row: Int, _ column: Int, _ newColor: Int, _ oldColor: Int) -> [[Int]] {
        var mutableImage = image
        if (row-1) >= 0 && (0..<image[0].count).contains(column) {
            if (image[row][column] == oldColor) {
                mutableImage[row][column] = newColor
                mutableImage =  fillRecursion(mutableImage, row-1, column, newColor, oldColor)
            }
        }
        
        if (column-1) >= 0 && (0..<image.count).contains(row) {
            if (image[row][column] == oldColor) {
                mutableImage[row][column] = newColor
                mutableImage = fillRecursion(mutableImage, row, column-1, newColor, oldColor)
            }
        }
        
        if (row+1) < image.count && (0..<image[0].count).contains(column) {
            if (image[row][column] == oldColor) {
                mutableImage[row][column] = newColor
                mutableImage = fillRecursion(mutableImage, row+1, column, newColor, oldColor)
            }
        }
        
        if (column+1) < image[0].count && (0..<image.count).contains(row){
            if (image[row][column] == oldColor) {
                mutableImage[row][column] = newColor
                mutableImage = fillRecursion(mutableImage, row, column+1, newColor, oldColor)
            }
        }
        return mutableImage
    }
}
