import UIKit

extension UISwipeGestureRecognizer {
    
    convenience init(_ direction: UISwipeGestureRecognizer.Direction, onView view: UIView) {
        self.init()
        self.direction = direction
        view.addGestureRecognizer(self)
    }
}
