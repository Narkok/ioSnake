import RxSwift
import RxCocoa

struct RxTimer {
    
    static func interval(_ period: RxTimeInterval) -> Observable<Int> {
        Observable<Int>.interval(period, scheduler: MainScheduler.asyncInstance)
    }
}
