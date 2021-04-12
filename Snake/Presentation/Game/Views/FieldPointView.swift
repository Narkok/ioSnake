import UIKit

final class FieldPointView: View {

    // MARK: - Private Properties
    
    private let pointView = UIView()
    
    // MARK: - Life Cycle
    
    override func setupUI() {
        super.setupUI()
        
        addSubview(pointView)
        pointView.snp.makeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalToSuperview().multipliedBy(FieldPointState.empty.relativeSize)
        }
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        
        pointView.layer.cornerRadius = pointView.bounds.height / 2
    }
    
    // MARK: - Public Methods
    
    func set(state: FieldPointState, animated: Bool) {
        
        pointView.snp.remakeConstraints {
            $0.center.equalToSuperview()
            $0.size.equalToSuperview().multipliedBy(state.relativeSize)
        }
        
        if animated {
            UIView.animate(withDuration: 0.2) {
                self.pointView.backgroundColor = state.color
                self.layoutIfNeeded()
            }
        } else {
            pointView.backgroundColor = state.color
        }
    }
}
