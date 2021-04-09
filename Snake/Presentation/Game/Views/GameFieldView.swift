import Foundation
import UIKit

final class GameFieldView: View {
    
    // MARK: - Public Properties
    
    private var columns: Int = 10
    
    private var rows: Int = 10
    
    // MARK: - Private Properties
    
     var fieldPoints: [[FieldPointView]] = []
    
    // MARK: - Life Cycle
    
    override func setupUI() {
        super.setupUI()
        
        let rootStackView: UIStackView = {
            let stackView = UIStackView()
            stackView.axis = .vertical
            stackView.alignment = .fill
            stackView.distribution = .fillEqually
            stackView.spacing = 0
            return stackView
        }()
        
        addSubview(rootStackView)
        rootStackView.snp.makeConstraints {
            $0.edges.equalToSuperview()
        }
        
        for _ in 0..<rows {
            
            var rowPoints: [FieldPointView] = []
            
            let rowStackView: UIStackView = {
                let stackView = UIStackView()
                stackView.axis = .horizontal
                stackView.alignment = .fill
                stackView.distribution = .fillEqually
                stackView.spacing = 0
                return stackView
            }()
            
            rootStackView.addArrangedSubview(rowStackView)
            
            for _ in 0..<columns {
                
                let pointView = FieldPointView()
                rowStackView.addArrangedSubview(pointView)
                rowPoints.append(pointView)
            }
            
            fieldPoints.append(rowPoints)
        }
    }
}
