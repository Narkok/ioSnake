import RxSwift
import RxCocoa

class LoopedRelay<T> {
    
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
