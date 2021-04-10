import UIKit
import RxSwift
import RxCocoa

class ViewController<RootView: View>: UIViewController {
    
    // MARK: - Public Properties

    let rootView = RootView()
    let disposeBag = DisposeBag()

    // MARK: - Life Cycle

    override func loadView() {
        view = rootView
    }
}
