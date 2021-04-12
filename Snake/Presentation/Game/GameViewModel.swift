import Foundation
import RxCocoa
import RxSwift

final class GameViewModel {
    
    let output: Output
    let input = Input()
    
    private let looped = Loop()
    
    init() {
        
        let food = looped.headOnFood.output
            .map { _ in Point.random(inRect: Constants.fieldSize) }
            .startWith(Point.random(inRect: Constants.fieldSize))
            .share(replay: 1)
        
        let grow = looped.headOnFood.output
            .map { _ in Snake.Change.grow }
        
        let changeDirection = input.direction
            .map { Snake.Change.newDirection($0) }
        
        let tick = looped.interval.output
            .flatMapLatest { RxTimer.interval(.milliseconds($0)) }
            .asVoid()
            .throttle(.milliseconds(Constants.minimalInterval))
            .share()
        
        let move = tick
            .map { _ in Snake.Change.update }
        
        let snake = Observable
            .merge(grow, move, changeDirection)
            .scan(Snake(fieldSize: Constants.fieldSize)) { $0.apply($1) }
            .share()
        
        let headPoint = snake
            .map { $0.headPoint }
            .distinctUntilChanged()
            .filterNil()
        
        let gameOver = snake
            .map { $0.isDead }
            .asVoid()
        
        looped.interval.input = snake
            .map { $0.length }
            .distinctUntilChanged()
            .map { 900 / $0 + Constants.minimalInterval }
            .startWith(600)
        
        looped.headOnFood.input = Observable
            .combineLatest(headPoint, food)
            .map { $0 == $1 }
            .distinctUntilChanged()
            .filter { $0 }
            .asVoid()
            .share()
        
        output = Output(
            snake: snake,
            food: food,
            gameOver: gameOver,
            tick: tick
        )
    }
    
    struct Input {
        let direction = PublishRelay<Snake.Direction>()
    }
    
    struct Output {
        let snake: Observable<Snake>
        let food: Observable<Point>
        let gameOver: Observable<Void>
        let tick: Observable<Void>
    }
    
    struct Loop {
        let headOnFood = LoopedRelay<Void>()
        let interval = LoopedRelay<Int>()
    }
}
