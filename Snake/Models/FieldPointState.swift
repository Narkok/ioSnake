import Foundation
import UIKit

enum FieldPointState: CaseIterable {
    case empty
    case snake
    case food
    
    var color: UIColor {
        switch self {
        case .empty: return UIColor(named: "Field")!
        case .snake: return UIColor(named: "Snake")!
        case .food:  return UIColor(named: "Food")!
        }
    }
    
    var relativeSize: Float {
        switch self {
        case .empty: return 0.3
        case .snake: return 0.8
        case .food:  return 0.5
        }
    }
}
