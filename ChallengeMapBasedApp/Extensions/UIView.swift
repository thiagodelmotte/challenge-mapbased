
import UIKit

extension UIView {
    
    func rounded(_ radius: CGFloat = 0) {
        self.layer.cornerRadius = (radius == 0) ? self.bounds.width / 2 : radius
        self.clipsToBounds = true
    }
    
    func dashedLine(_ cgColor: CGColor) {
        let borderLayer = CAShapeLayer()
        borderLayer.strokeColor = cgColor
        borderLayer.lineDashPattern = [6, 6]
        borderLayer.backgroundColor = StyleGuide.color.clear.cgColor
        borderLayer.fillColor = StyleGuide.color.clear.cgColor
        borderLayer.path = UIBezierPath(roundedRect: self.bounds, cornerRadius: 8).cgPath
        self.layer.addSublayer(borderLayer)
    }
    
}

