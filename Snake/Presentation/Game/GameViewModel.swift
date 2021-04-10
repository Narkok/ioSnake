import Foundation
import RxCocoa
import RxSwift

final class GameViewModel {
    
    let output: Output
    let input = Input()
    
    init(rows: Int = 10, columns: Int = 10) {
        let initialSnake = Snake.generate(fieldSizeX: rows, y: columns)
        
        let initialFood = input.tick.first()
            .asObservable()
            .map { _ in Point.random(inRangeX: 0..<rows, rangeY: 0..<columns) }
        
        let move = input.tick
            .map { _ in Snake.Change.move }
        
        let snake = Observable
            .merge(move, input.change.asObservable())
            .scan(initialSnake) { $0.apply(change: $1) }
            .share()
        
        let gameOver = snake
            .map { $0.isDead }
            .asVoid()
        
        output = Output(
            snake: snake,
            food: initialFood,
            gameOver: gameOver,
            tick: input.tick.asObservable()
        )
    }
    
    struct Input {
        let change = PublishRelay<Snake.Change>()
        let tick = PublishRelay<Void>()
    }
    
    struct Output {
        let snake: Observable<Snake>
        let food: Observable<Point>
        let gameOver: Observable<Void>
        let tick: Observable<Void>
    }
}
