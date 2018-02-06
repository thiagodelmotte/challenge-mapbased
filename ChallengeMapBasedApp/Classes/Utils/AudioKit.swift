
import Foundation
import UIKit
import AudioToolbox

class AudioKit {
    
    class func vibrate() {
        AudioServicesPlayAlertSound(SystemSoundID(kSystemSoundID_Vibrate))
    }
    
}
