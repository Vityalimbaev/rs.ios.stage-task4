import Foundation

public extension Int {
    
    var roman: String? {
    
        
        return reduction(self)
    }
    
    
    func reduction(_ num: Int) -> String? {
    
        if num >= 1000 {
            return "M" + (reduction(num - 1000) ?? "")
        } else if num >= 900 {
            return "CM" + (reduction(num - 900) ?? "")
        } else if num >= 500 {
            return "D" + (reduction(num - 500) ?? "")
        } else if num >= 400 {
            return "CD" + (reduction(num - 400) ?? "")
        } else if num >= 100 {
            return "C" + (reduction(num - 100) ?? "")
        } else if num >= 90 {
            return "XC" + (reduction(num - 90) ?? "")
        } else if num >= 50 {
            return "L" + (reduction(num - 50) ?? "")
        } else if num >= 40 {
            return "XL" + (reduction(num - 40) ?? "")
        } else if num >= 10 {
            return "X" + (reduction(num - 10) ?? "")
        } else if num >= 9 {
            return "IX" + (reduction(num - 9) ?? "")
        } else if num >= 5 {
            return "V" + (reduction(num - 5) ?? "")
        } else if num >= 4 {
            return "IV" + (reduction(num - 4) ?? "")
        } else if num > 0 {
            return "I" + (reduction(num - 1) ?? "")
        }
        return nil
    }
}
