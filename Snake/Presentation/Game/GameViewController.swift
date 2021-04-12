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
        
        rootView.direction
            .bind(to: viewModel.input.direction)
            .disposed(by: disposeBag)
    }
}
