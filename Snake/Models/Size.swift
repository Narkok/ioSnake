import Foundation
import UIKit

struct Size {
    
    var width: Int
    var height: Int
    
    var ratio: CGFloat {
        CGFloat(height) / CGFloat(width)
    }
}
