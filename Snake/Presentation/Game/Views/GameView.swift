import RxSwift
import RxCocoa
import UIKit

final class GameView: View {
    
    // MARK: - Private Properties
    
    private let gameFieldView = GameFieldView()
    private let disposeBag = DisposeBag()
    
    // MARK: - Public Properties
    
    let direction = PublishRelay<Direction>()
    
    // MARK: - Life Cycle
    
    override func commonInit() {
        super.commonInit()
        
        let up = UISwipeGestureRecognizer(.up, onView: self)
            .rx.event.map { _ in Direction.up }
        
        let left = UISwipeGestureRecognizer(.left, onView: self)
            .rx.event.map { _ in Direction.left }
        
        let right = UISwipeGestureRecognizer(.right, onView: self)
            .rx.event.map { _ in Direction.right }
        
        let down = UISwipeGestureRecognizer(.down, onView: self)
            .rx.event.map { _ in Direction.down }
        
        Observable.merge(up, left, right, down)
            .bind(to: direction)
            .disposed(by: disposeBag)
    }
    
    override func setupUI() {
        super.setupUI()
        
        backgroundColor = UIColor(named: "Background")
        
        addSubview(gameFieldView)
        gameFieldView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.width.equalToSuperview().multipliedBy(0.92)
            $0.height.equalTo(gameFieldView.snp.width).multipliedBy(Constants.fieldSize.ratio)
        }
    }
    
    // MARK: - Public Methods
    
    func update(snake: Snake) {
        gameFieldView.draw(snake: snake)
    }
    
    func set(food: Point) {
        gameFieldView.set(food: food)
    }
}

// MARK: - Reactive Extension

extension Reactive where Base: GameView {
    
    internal var snake: Binder<Snake> {
        Binder(self.base) { view, snake in
            view.update(snake: snake)
        }
    }
    
    internal var food: Binder<Point> {
        Binder(self.base) { view, food in
            view.set(food: food)
        }
    }
}
