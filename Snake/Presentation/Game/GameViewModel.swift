import Foundation
import RxCocoa
import RxSwift

final class GameViewModel {
    
    let output: Output
    let input = Input()
    
    init() {
        
        let initialSnake = Snake.generate(fieldSize: Constants.fieldSize)
        
        let food = input.tick.first()
            .asObservable()
            .map { _ in Point.random(inRect: Constants.fieldSize) }
        
        let move = input.tick
            .map { _ in Snake.Change.update }
        
        let snake = Observable
            .merge(move, input.change.asObservable())
            .scan(initialSnake) { $0.apply(change: $1) }
            .share()
        
        let gameOver = snake
            .map { $0.isDead }
            .asVoid()
        
        let interval = snake
            .map { $0.length }
            .distinctUntilChanged()
            .map { 700 / $0 + Constants.minimalInterval }
            .startWith(600)
        
        output = Output(
            snake: snake,
            food: food,
            gameOver: gameOver,
            tick: input.tick.asObservable(),
            interval: interval
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
        let interval: Observable<Int>
    }
}
