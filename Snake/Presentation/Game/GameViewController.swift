import UIKit
import RxCocoa
import RxSwift

class GameViewController: ViewController<GameView> {
    
    // MARK: - Private Properties
    
    private let viewModel = GameViewModel()
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupInputs()
        setupOutputs()
    }
    
    // MARK: - Private Methods
    
    private func setupInputs() {
        
        viewModel.output.snake
            .bind(to: rootView.rx.snake)
            .disposed(by: disposeBag)
        
        viewModel.output.food
            .bind(to: rootView.rx.food)
            .disposed(by: disposeBag)
        
        viewModel.output.tick
            .bind(to: rx.lightFeedback)
            .disposed(by: disposeBag)
    }
    
    private func setupOutputs() {
        
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
