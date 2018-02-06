
import UIKit

class StyleGuide {
    
    struct color {
        static let clear = UIColor.clear
        static let white = UIColor.white
        static let black = UIColor.black
        static let darkGray = UIColor(r: 102, g: 102, b: 102, a: 1)
        static let mediumGray = UIColor(r: 128, g: 128, b: 128, a: 1)
        static let gray = UIColor(r: 153, g: 153, b: 153, a: 1)
        static let lightGray = UIColor(r: 204, g: 204, b: 204, a: 1)
        static let blue = UIColor(r: 11, g: 77, b: 137, a: 1)
        static let blueBg = UIColor(r: 9, g: 71, b: 128, a: 1)
        static let blueStrong = UIColor(r: 13, g: 84, b: 149, a: 1)
        static let blueLight = UIColor(r: 51, g: 153, b: 255, a: 1)
        static let blueClear = UIColor(r: 48, g: 124, b: 193, a: 1)
        static let blueLine = UIColor(r: 83, g: 173, b: 255, a: 1)
        static let blueFacebook = UIColor(r: 57, g: 90, b: 157, a: 1)
        static let blueDegradeDark = UIColor(r: 0, g: 57, b: 121, a: 1)
        static let blueDegradeLight = UIColor(r: 1, g: 163, b: 231, a: 1)
        static let orange = UIColor(r: 255, g: 153, b: 51, a: 1)
    }
    
    struct font {
        static let thirty = UIFont().montserrat(type: .regular, fontSize: 30)
        static let twentyEight = UIFont().montserrat(type: .regular, fontSize: 28)
        static let twentySeven = UIFont().montserrat(type: .regular, fontSize: 27)
        static let twentyFour = UIFont().montserrat(type: .regular, fontSize: 24)
        static let twenty = UIFont().montserrat(type: .regular, fontSize: 20)
        static let nineteen = UIFont().montserrat(type: .regular, fontSize: 19)
        static let eighteen = UIFont().montserrat(type: .regular, fontSize: 18)
        static let seventeen = UIFont().montserrat(type: .regular, fontSize: 17)
        static let sixteen = UIFont().montserrat(type: .regular, fontSize: 16)
        static let fifteen = UIFont().montserrat(type: .regular, fontSize: 15)
        static let fourteen = UIFont().montserrat(type: .regular, fontSize: 14)
        static let thirteen = UIFont().montserrat(type: .regular, fontSize: 13)
        static let twelve = UIFont().montserrat(type: .regular, fontSize: 12)
        static let eleven = UIFont().montserrat(type: .regular, fontSize: 11)
        static let ten = UIFont().montserrat(type: .regular, fontSize: 10)
    }
    
}
