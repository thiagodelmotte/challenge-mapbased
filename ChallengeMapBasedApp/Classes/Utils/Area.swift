
import Foundation
import UIKit
import CoreLocation

class Area {
    
    class func radians(_ degrees: Double) -> Double {
        return degrees * .pi / 180;
    }
    
    class func regionArea(_ locations: [CLLocationCoordinate2D]) -> Double {
        
        guard locations.count > 2 else { return 0 }
        var area = 0.0
        
        for i in 0..<locations.count {
            let p1 = locations[i > 0 ? i - 1 : locations.count - 1]
            let p2 = locations[i]
            
            area += radians(p2.longitude - p1.longitude) * (2 + sin(radians(p1.latitude)) + sin(radians(p2.latitude)) )
        }
        
        let kEarthRadius = 6378137.0
        area = -(area * kEarthRadius * kEarthRadius / 2);
        
        return max(area, -area)
        
    }
    
}
