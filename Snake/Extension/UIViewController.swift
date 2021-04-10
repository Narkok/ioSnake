import RxCocoa
import RxSwift
import UIKit

extension Reactive where Base: UIViewController {
    
    internal var lightFeedback: Binder<Void> {
        Binder(base.self) { _, intensity  in
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred()
        }
    }
    
    internal var successFeedback: Binder<Void> {
        Binder(base.self) { _, intensity  in
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
        }
    }
    
    internal var errorFeedback: Binder<Void> {
        Binder(base.self) { _, intensity  in
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.error)
        }
    }
}
