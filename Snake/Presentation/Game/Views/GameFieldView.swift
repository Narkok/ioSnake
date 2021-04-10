import Foundation
import UIKit

final class GameFieldView: View {
    
    // MARK: - Public Properties
    
    private var fieldSize = Constants.fieldSize
    
    private var food: Point?
    
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
        
        for _ in 0..<fieldSize.height {
            
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
            
            for _ in 0..<fieldSize.width {
                
                let pointView = FieldPointView()
                pointView.set(state: .empty, animated: true)
                rowStackView.addArrangedSubview(pointView)
                rowPoints.append(pointView)
            }
            
            fieldPoints.append(rowPoints)
        }
    }
    
    // MARK: - Public Methods
    
    func set(food: Point) {
        self.food = food
        fieldPoints[food.y][food.x].set(state: .food, animated: true)
    }
    
    func draw(snake: Snake) {
        for (rowIndex, row)  in fieldPoints.enumerated() {
            for (columnIndex, fieldPoint) in row.enumerated() {
                let point = Point(x: columnIndex, y: rowIndex)
                
                if snake.points.contains(point) {
                    fieldPoint.set(state: .snake, animated: true)
                } else if food == point {
                    fieldPoint.set(state: .food, animated: true)
                } else {
                    fieldPoint.set(state: .empty, animated: true)
                }
            }
        }
    }
}
