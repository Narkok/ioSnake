import Foundation
import RxCocoa
import RxSwift

final class GameViewModel {
    
    let output: Output
    let input = Input()
    
    init(fieldSize: Size = Constants.fieldSize) {
        
        let initialSnake = Snake.generate(fieldSize: fieldSize)
        
        let initialFood = input.tick.first()
            .asObservable()
            .map { _ in Point.random(inSize: fieldSize) }
        
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
