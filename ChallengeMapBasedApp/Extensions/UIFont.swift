
import UIKit

extension UIFont {
    
    enum montserratFontType: String {
        case regular = "Montserrat-Regular"
        case light = "Montserrat-Light"
        case bold = "Montserrat-Bold"
        case black = "Montserrat-Black"
        case hairline = "Montserrat-Hairline"
    }
    
    func montserrat(type: montserratFontType, fontSize: CGFloat = 0) -> UIFont {
        let size = (fontSize == 0) ? self.pointSize : fontSize
        return UIFont(name: type.rawValue, size: size)!
    }
    
    func light() -> UIFont {
        return self.montserrat(type: .light)
    }
    
    func bold() -> UIFont {
        return self.montserrat(type: .bold)
    }
    
    func black() -> UIFont {
        return self.montserrat(type: .black)
    }
    
    func hairline() -> UIFont {
        return self.montserrat(type: .hairline)
    }
    
}
