import RxSwift
import RxCocoa
import UIKit

final class GameView: View {
    
    // MARK: - Private Properties
    
    private let gameFieldView = GameFieldView()
    private let disposeBag = DisposeBag()
    
    // MARK: - Public Properties
    
    let direction = PublishRelay<Snake.Direction>()
    
    // MARK: - Life Cycle
    
    override func commonInit() {
        super.commonInit()
        
        let upSwipeGesture = UISwipeGestureRecognizer()
        upSwipeGesture.direction = .up
        let up = upSwipeGesture.rx.event.map { _ in Snake.Direction.up }
        
        let leftSwipeGesture = UISwipeGestureRecognizer()
        leftSwipeGesture.direction = .left
        let left = leftSwipeGesture.rx.event.map { _ in Snake.Direction.left }
        
        let rightSwipeGesture = UISwipeGestureRecognizer()
        rightSwipeGesture.direction = .right
        let right = rightSwipeGesture.rx.event.map { _ in Snake.Direction.right }
        
        let downSwipeGesture = UISwipeGestureRecognizer()
        downSwipeGesture.direction = .down
        let down = downSwipeGesture.rx.event.map { _ in Snake.Direction.down }
        
        [upSwipeGesture, leftSwipeGesture, rightSwipeGesture, downSwipeGesture].forEach {
            addGestureRecognizer($0)
        }
        
        Observable.merge(up, left, right, down)
            .bind(to: direction)
            .disposed(by: disposeBag)
    }
    
    override func setupUI() {
        super.setupUI()
        
        backgroundColor = UIColor(named: "Background")
        
        addSubview(gameFieldView)
        gameFieldView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(12)
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
