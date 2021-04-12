import Foundation
import RxCocoa
import RxSwift

final class GameViewModel {
    
    let output: Output
    let input = Input()
    
    private let reverse = Reverse()
    
    init() {
        
        let food = reverse.headOnFood.output
            .map { _ in Point.random(inRect: Constants.fieldSize) }
            .startWith(Point.random(inRect: Constants.fieldSize))
            .share(replay: 1)
        
        let grow = reverse.headOnFood.output
            .map { _ in Snake.Change.grow }
        
        let changeDirection = input.direction
            .map { Snake.Change.newDirection($0) }
        
        let move = input.tick
            .map { _ in Snake.Change.update }
        
        let snake = Observable
            .merge(grow, move, changeDirection)
            .scan(Snake.generate(fieldSize: Constants.fieldSize)) { $0.apply($1) }
            .share()
        
        let headPoint = snake
            .map { $0.headPoint }
            .distinctUntilChanged()
            .filterNil()
        
        let gameOver = snake
            .map { $0.isDead }
            .asVoid()
        
        let interval = snake
            .map { $0.length }
            .distinctUntilChanged()
            .map { 900 / $0 + Constants.minimalInterval }
            .startWith(600)
        
        reverse.headOnFood.input = Observable
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
            tick: input.tick.asObservable(),
            interval: interval
        )
    }
    
    struct Input {
        let direction = PublishRelay<Snake.Direction>()
        let tick = PublishRelay<Void>()
    }
    
    struct Output {
        let snake: Observable<Snake>
        let food: Observable<Point>
        let gameOver: Observable<Void>
        let tick: Observable<Void>
        let interval: Observable<Int>
    }
    
    struct Reverse {
        let headOnFood = ReversedRelay<Void>()
    }
}


class ReversedRelay<T> {
    
    private var disposeBag = DisposeBag()
    
    private let relay = PublishRelay<T>()
    
    var output: Observable<T> { relay.asObservable() }
    
    var input: Observable<T> = .never() {
        didSet {
            dispose()
            input.share(replay: 1)
                .observeOn(MainScheduler.asyncInstance)
                .bind(to: relay)
                .disposed(by: disposeBag)
        }
    }
    
    func dispose() {
        disposeBag = DisposeBag()
    }
}
