import UIKit

class LoadingViewController: UIViewController {
    
    @IBOutlet weak var point1: FieldPointView!
    @IBOutlet weak var point2: FieldPointView!
    @IBOutlet weak var point3: FieldPointView!
    @IBOutlet weak var point4: FieldPointView!
    @IBOutlet weak var point5: FieldPointView!
    @IBOutlet weak var point6: FieldPointView!

    override func viewDidLoad() {
        super.viewDidLoad()

        [point1, point2, point3, point5, point6]
            .forEach { $0?.set(state: .empty, animated: false) }
        point4.set(state: .food, animated: false)
        
        Timer.scheduledTimer(withTimeInterval: 1, repeats: false) { _ in
            self.point1.set(state: .snake, animated: true)
        }
        
        Timer.scheduledTimer(withTimeInterval: 1.3, repeats: false) { _ in
            self.point2.set(state: .snake, animated: true)
        }
        
        Timer.scheduledTimer(withTimeInterval: 1.6, repeats: false) { _ in
            self.point3.set(state: .snake, animated: true)
            self.point1.set(state: .empty, animated: true)
        }
        
        Timer.scheduledTimer(withTimeInterval: 1.9, repeats: false) { _ in
            self.point4.set(state: .snake, animated: true)
            self.point2.set(state: .empty, animated: true)
        }
        
        Timer.scheduledTimer(withTimeInterval: 2.2, repeats: false) { _ in
            self.point5.set(state: .snake, animated: true)
        }
        
        Timer.scheduledTimer(withTimeInterval: 2.5, repeats: false) { _ in
            self.point6.set(state: .snake, animated: true)
            self.point3.set(state: .empty, animated: true)
        }
        
        Timer.scheduledTimer(withTimeInterval: 2.8, repeats: false) { _ in
            self.point4.set(state: .empty, animated: true)
        }
        
        Timer.scheduledTimer(withTimeInterval: 3.1, repeats: false) { _ in
            self.point5.set(state: .empty, animated: true)
        }
        
        Timer.scheduledTimer(withTimeInterval: 3.4, repeats: false) { _ in
            self.point6.set(state: .empty, animated: true)
        }
        
        Timer.scheduledTimer(withTimeInterval: 4, repeats: false) { _ in
            let gameViewController = GameViewController()
            gameViewController.modalPresentationStyle = .fullScreen
            gameViewController.modalTransitionStyle = .crossDissolve
            self.present(gameViewController, animated: true)
        }
    }
}
