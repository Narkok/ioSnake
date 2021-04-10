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
        
        
        self.pointView.snp.remakeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalToSuperview().multipliedBy(state.relativeSize)
        }
        
        if animated {
            UIView.animate(withDuration: 0.3) {
                self.pointView.backgroundColor = state.color
                self.layoutIfNeeded()
            }
        }
    }
}
