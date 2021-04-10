import Foundation
import UIKit

struct Snake {
    
    // MARK: - Public Properties
    
    private(set) var isDead: Bool = false
    private(set) var points: [Point]
    
    // MARK: - Public Properties
    
    private var direction: Direction
    private var isGrowing = false
    
    // MARK: - Initialization
    
    init(direction: Direction, points: [Point]) {
        self.direction = direction
        self.points = points
    }
    
    // MARK: - Public Methods
    
    func apply(change: Change) -> Snake {
        switch change {
        case .grow:
            return self.grow()
        case .move:
            return self.move()
        case .newDirection(let newDir):
            return self.change(direction: newDir)
        }
    }
    
    // MARK: - Private Methods

    private func move() -> Snake {
        var snake = self
        guard var forwardPoint = snake.points.first else { return snake }
        if !isGrowing {
            snake.points = snake.points.dropLast()
            snake.isGrowing = false
        }
        forwardPoint = forwardPoint + direction.delta
        snake.points.insert(forwardPoint, at: 0)
        return snake
    }
    
    private func change(direction: Direction) -> Snake {
        var snake = self
        if direction.delta + snake.direction.delta != Point(x: 0, y: 0) {
            snake.direction = direction
        }
        return snake
    }
    
    private func grow() -> Snake {
        var snake = self
        snake.isGrowing = true
        return snake
    }
    
    // MARK: - Static Methods
    
    static func generate(fieldSizeX x: Int, y: Int) -> Snake {
        let direction = Direction.allCases.randomElement() ?? .left
        let point = Point(x: x / 2, y: x / 2)
        let tail = point + direction.delta
        return Snake(direction: direction, points: [point, tail])
    }
}


extension Snake {
    
    // MARK: - Types
    
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
    
    enum Change {
        case grow
        case newDirection(Direction)
        case move
    }
}
