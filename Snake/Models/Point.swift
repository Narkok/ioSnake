import Foundation
import UIKit

struct Point: Equatable {

    var x: Int
    var y: Int
    
    static func random(inSize size: Size) -> Point {
        Point(x: (0..<size.width).randomElement() ?? 0, y: (0..<size.height).randomElement() ?? 0)
    }
    
    static func +(lhs: Point, rhs: Point) -> Point {
        Point(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
    
    static func -(lhs: Point, rhs: Point) -> Point {
        Point(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }
}
