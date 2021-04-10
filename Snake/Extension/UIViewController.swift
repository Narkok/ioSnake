import RxCocoa
import RxSwift
import UIKit

extension Reactive where Base: UIViewController {
    
    internal var lightFeedback: Binder<Void> {
        Binder(base.self) { _, intensity  in
            let generator = UIImpactFeedbackGenerator(style: .light)
            generator.impactOccurred(intensity: 0.6)
        }
    }
    
    internal var heavyFeedback: Binder<Void> {
        Binder(base.self) { _, intensity  in
            let generator = UIImpactFeedbackGenerator(style: .heavy)
            generator.impactOccurred(intensity: 0.8)
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
