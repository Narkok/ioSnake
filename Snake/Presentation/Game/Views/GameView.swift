import Foundation
import UIKit

final class GameView: View {
    
    // MARK: - Private Properties
    
    private let gameFieldView = GameFieldView()
    
    // MARK: - Life Cycle
    
    override func setupUI() {
        super.setupUI()
        
        backgroundColor = UIColor(named: "Background")
        
        addSubview(gameFieldView)
        gameFieldView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.leading.trailing.equalToSuperview().inset(12)
            $0.height.equalTo(gameFieldView.snp.width)
        }
        
        for point in gameFieldView.fieldPoints {
            for a in point {
                a.set(state: FieldPointState.allCases.randomElement()!, animated: true)
            }
        }
    }
}
