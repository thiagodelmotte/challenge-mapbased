
import UIKit

extension UIButton {
    
    func translucentRounded() {
        self.layer.cornerRadius = self.bounds.height / 2
        self.backgroundColor = StyleGuide.color.black.withAlpha(0.5)
        self.setTitleColor(StyleGuide.color.white, for: .normal)
        self.titleLabel?.font = StyleGuide.font.sixteen
        self.layer.borderWidth = 0.5
        self.layer.borderColor = StyleGuide.color.white.cgColor
    }
    
}
