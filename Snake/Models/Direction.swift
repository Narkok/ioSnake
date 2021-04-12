import Foundation

enum Direction: CaseIterable {
    case up
    case left
    case right
    case down
    
    var delta: Point {
        switch self {
        case .up: return Point(x: 0, y: -1)
        case .left: return Point(x: -1, y: 0)
        case .right: return Point(x: 1, y: 0)
        case .down: return Point(x: 0, y: 1)
        }
    }
}
