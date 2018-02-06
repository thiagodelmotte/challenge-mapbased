
import UIKit

extension UIColor {
    
    convenience init(r: CGFloat, g: CGFloat , b: CGFloat , a: CGFloat) {
        self.init(red: r/255, green: g/255, blue: b/255, alpha: a)
    }
    
    var coreImageColor: CoreImage.CIColor {
        return CoreImage.CIColor(color: self)
    }
    
    func withAlpha(_ a: CGFloat) -> UIColor {
        return UIColor(red: self.coreImageColor.red, green: self.coreImageColor.green, blue: self.coreImageColor.blue, alpha: a)
    }
    
}
