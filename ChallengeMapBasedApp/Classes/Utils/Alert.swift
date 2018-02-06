
import Foundation
import UIKit
import SwiftyDrop

class Alert {
    
    enum alertStyle {
        case success
        case warning
        case error
    }
    
    fileprivate class func getMessageTitle(_ style: alertStyle) -> String {
        
        switch style {
            case .success:
                return "generalAlertSuccessTitle".localized()
            case .warning:
                return "generalAlertWarningTitle".localized()
            default:
                return "generalAlertErrorTitle".localized()
        }
        
    }
    
    class func connectionError(_ sender: UIViewController) {
        self.createAlertWithOkAction(sender, style: .error, title: nil, message: "generalConnectionErrorMessage".localized(), action: nil)
    }
    
    class func connectionErrorBanner() {
        Drop.down("generalConnectionErrorMessage".localized(), state: .error, duration: 3.0, action: nil)
    }
    
    class func banner(_ message: String, state: DropState, duration: Double = 3.0, action: DropAction? = nil) {
        Drop.down(message, state: state, duration: duration, action: action)
    }
    
    class func createAlertWithOkAction(_ sender: UIViewController, style: alertStyle, title: String?, message: String?, action: ((UIAlertAction) -> Void)?) {
        
        let titleStr = title ?? self.getMessageTitle(style)
        let alert = UIAlertController(title: titleStr, message: message, preferredStyle: UIAlertControllerStyle.alert)
        let okAction = UIAlertAction(title: "Ok", style: .default, handler: action)
        alert.addAction(okAction)
        
        sender.present(alert, animated: true, completion: nil)
        
    }
    
    class func createAlertWithActions(_ sender: UIViewController, style: alertStyle, title: String?, message: String?, actions: [UIAlertAction]) {
        
        let titleStr = title ?? self.getMessageTitle(style)
        let alert = UIAlertController(title: titleStr, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        for action in actions {
            alert.addAction(action)
        }
        
        sender.present(alert, animated: true, completion: nil)
        
    }
    
    class func createAlertWithTextField(_ style: alertStyle, title: String?, message: String?, placeholder: String?) -> UIAlertController {
        
        let titleStr = title ?? self.getMessageTitle(style)
        let alert = UIAlertController(title: titleStr, message: message, preferredStyle: UIAlertControllerStyle.alert)
        
        alert.addTextField { (textField : UITextField!) -> Void in
            textField.placeholder = placeholder
            textField.textAlignment = .center
            textField.keyboardType = .numberPad
        }
        
        return alert
        
    }
    
    class func createActionSheet(_ controller: UIViewController, title: String?, message: String?, actions: [UIAlertAction], sourceView: UIView?, barButtonItem: UIBarButtonItem?) {
        
        let alert = UIAlertController(title: title, message: message, preferredStyle: .actionSheet)
        alert.view.tintColor = StyleGuide.color.blue
        
        if title != nil {
            formatAlertTexts(alert, type: "attributedTitle", text: title, font: StyleGuide.font.eighteen, color: StyleGuide.color.black.withAlpha(0.6))
        }
        
        if message != nil {
            formatAlertTexts(alert, type: "attributedMessage", text: message, font: StyleGuide.font.fourteen, color: StyleGuide.color.black.withAlpha(0.6))
        }
        
        for action in actions {
            alert.addAction(action)
        }
        
        if let popoverController = alert.popoverPresentationController {
            
            if let view = sourceView {
                popoverController.sourceView = view
            } else if let button = barButtonItem {
                popoverController.barButtonItem = button
            }
            
        }
        
        controller.present(alert, animated: true, completion:nil)
        
    }
    
    fileprivate class func formatAlertTexts(_ alertController: UIAlertController, type: String, text: String?, font: UIFont, color: UIColor) {
        let attr = NSAttributedString(string: text ?? "", attributes: [NSAttributedStringKey.font: font, NSAttributedStringKey.foregroundColor: color])
        alertController.setValue(attr, forKey: type)
    }
    
}
