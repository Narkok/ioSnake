import Foundation
import UIKit

struct Snake {
    
    // MARK: - Public Properties
    
    private(set) var isDead: Bool
    private(set) var points: [Point]
    
    var length: Int { points.count }
    var headPoint: Point? { points.first }
    
    // MARK: - Public Properties
    
    private var direction: Direction
    private var isGrowing: Bool
    
    private let fieldSize: Size
    
    // MARK: - Initialization
    
    init(points: [Point], direction: Direction, fieldSize: Size) {
        self.direction = direction
        self.fieldSize = fieldSize
        self.isGrowing = false
        self.isDead = false
        self.points = points
    }
    
    // MARK: - Public Methods
    
    func apply(_ change: Change) -> Snake {
        switch change {
        case .grow:
            return self.grow()
        case .update:
            return self.update()
        case .newDirection(let newDir):
            return self.change(direction: newDir)
        }
    }
    
    // MARK: - Private Methods

    private func update() -> Snake {
        var snake = self
        guard var forwardPoint = snake.points.first else { return snake }
        snake.points = isGrowing ? snake.points : snake.points.dropLast()
        snake.isGrowing = false
        forwardPoint = forwardPoint + direction.delta
        forwardPoint.x = (forwardPoint.x + fieldSize.width) % fieldSize.width
        forwardPoint.y = (forwardPoint.y + fieldSize.height) % fieldSize.height
        snake.points = [forwardPoint] + snake.points
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
    
    static func generate(fieldSize: Size) -> Snake {
        let direction = Direction.allCases.randomElement() ?? .left
        let head = Point(x: Int.random(in: 1..<fieldSize.width - 1), y: Int.random(in: 1..<fieldSize.height - 1))
        let tail = head - direction.delta
        return Snake(points: [head, tail], direction: direction, fieldSize: fieldSize)
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
        case update
    }
}
