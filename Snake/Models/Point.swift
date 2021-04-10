import Foundation
import UIKit

struct Point: Equatable {

    var x: Int
    var y: Int
    
    static func random(inRangeX rangeX: Range<Int>, rangeY: Range<Int>) -> Point {
        Point(x: rangeX.randomElement() ?? 0, y: rangeY.randomElement() ?? 0)
    }
    
    static func +(lhs: Point, rhs: Point) -> Point {
        Point(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
}

