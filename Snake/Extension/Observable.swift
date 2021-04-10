import RxCocoa
import RxSwift


public extension PublishRelay {
    
    func asDriver() -> Driver<Element> {
        return asDriver(onErrorDriveWith: Driver.empty())
    }
}


public extension Observable {
    
    func asTrue() -> Observable<Bool> {
        map { _ in true }
    }
    
    func asFalse() -> Observable<Bool> {
        map { _ in false }
    }

    func asDriver() -> Driver<Element> {
        asDriver(onErrorDriveWith: Driver.empty())
    }
    
    func asVoid() -> Observable<Void> {
        map { _ in () }
    }
    
    func filterNil<T>() -> Observable<T> where Element == T? {
        filter { $0 != nil }.map { $0! }
    }
    
    func delay(_ dueTime: RxTimeInterval) -> Observable<Element> {
        delay(dueTime, scheduler: MainScheduler.asyncInstance)
    }
}


public extension Driver {
    
    func asVoid() -> Driver<Void> {
        return map { _ in () } as! Driver<Void>
    }
    
    func filterNil<T>() -> Driver<T> where Element == T? {
        return self.filter { $0 != nil }.map { $0! } as! Driver<T>
    }
}
