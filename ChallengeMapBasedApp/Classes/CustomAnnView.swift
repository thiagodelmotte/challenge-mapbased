
import Foundation
import UIKit
import Mapbox

class CustomAnnView: MGLAnnotationView {
    
    override func layoutSubviews() {
        
        super.layoutSubviews()
        scalesWithViewingDistance = false
        
        layer.cornerRadius = frame.width / 2
        layer.borderWidth = 2
        layer.borderColor = UIColor.white.cgColor
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
        super.setSelected(selected, animated: animated)
        
        let animation = CABasicAnimation(keyPath: "borderWidth")
        animation.duration = 0.1
        layer.borderWidth = selected ? frame.width / 4 : 2
        layer.add(animation, forKey: "borderWidth")
        
    }
    
}
