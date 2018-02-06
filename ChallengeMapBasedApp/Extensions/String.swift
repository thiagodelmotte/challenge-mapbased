
import UIKit

extension String {
    
    func localized() -> String {
        return NSLocalizedString(self, comment: "")
    }
    
    func attributedColor(_ color: UIColor) -> NSAttributedString {
        return NSAttributedString(string: self, attributes: [NSAttributedStringKey.foregroundColor: color])
    }
    
    func attributedUnderline() -> NSAttributedString {
        return NSAttributedString(string: self, attributes: [NSAttributedStringKey.underlineStyle: NSUnderlineStyle.styleSingle.rawValue])
    }
    
    func trim() -> String {
        return self.trimmingCharacters(in: NSCharacterSet.whitespaces)
    }
    
    func isValidEmail() -> Bool {
        let regex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}"
        let emailTest = NSPredicate(format: "SELF MATCHES %@", regex)
        return emailTest.evaluate(with: self)
    }
    
    func nameReduced() -> String {
        
        let names = self.components(separatedBy: " ")
        
        guard names.count > 2 else {
            return self
        }
        
        return "\(names.first!) \(names.last!)"
        
    }
    
}
