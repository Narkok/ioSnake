import Foundation
import UIKit
import SnapKit

class View: UIView {
    
    // MARK: - Initialization
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        
        commonInit()
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        commonInit()
        setupUI()
    }
    
    // MARK: - Public Methods
    
    func commonInit() {}
    
    func setupUI() {}
}
