import UIKit

final class FieldPointView: View {

    // MARK: - Private Properties
    
    private let pointView = UIView()
    private var state: FieldPointState = .empty
    
    // MARK: - Life Cycle
    
    override func setupUI() {
        super.setupUI()
        
        addSubview(pointView)
        pointView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalToSuperview().multipliedBy(state.relativeSize)
        }
        
        set(state: state, animated: false)
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        pointView.layer.cornerRadius = pointView.bounds.height / 2
    }
    
    // MARK: - Public Methods
    
    func set(state: FieldPointState, animated: Bool) {
        self.state = state
        pointView.backgroundColor = state.color
    }
}

enum FieldPointState: CaseIterable {
    case empty
    case snake
    case food
    
    var color: UIColor {
        switch self {
        case .empty: return UIColor(named: "Field")!
        case .snake: return UIColor(named: "Snake")!
        case .food:  return UIColor(named: "Food")!
        }
    }
    
    var relativeSize: Float {
        switch self {
        case .empty: return 0.3
        case .snake: return 0.8
        case .food:  return 0.5
        }
    }
}
