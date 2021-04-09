import UIKit

class ViewController<RootView: View>: UIViewController {
    
    // MARK: - Public Properties

    let rootView = RootView()

    // MARK: - Life Cycle

    override func loadView() {
        view = rootView
    }
}
