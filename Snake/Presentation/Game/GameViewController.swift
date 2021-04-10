import UIKit
import RxCocoa
import RxSwift

class GameViewController: ViewController<GameView> {
    
    private let viewModel = GameViewModel()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel.output.snake
            .bind(to: rootView.rx.snake)
            .disposed(by: disposeBag)
        
        viewModel.output.food
            .bind(to: rootView.rx.food)
            .disposed(by: disposeBag)
        
        Observable<Int>
            .interval(.milliseconds(600), scheduler: MainScheduler.instance)
            .asVoid()
            .bind(to: viewModel.input.tick)
            .disposed(by: disposeBag)
        
        rootView.direction
            .map { Snake.Change.newDirection($0) }
            .bind(to: viewModel.input.change)
            .disposed(by: disposeBag)
    }
}
