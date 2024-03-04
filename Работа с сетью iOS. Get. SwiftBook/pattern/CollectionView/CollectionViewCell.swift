import UIKit

// MARK: CollectionViewCellProtocol
protocol CollectionViewCellProtocol {
    var label: UILabel { get set }
}

class CollectionViewCell: UICollectionViewCell, CollectionViewCellProtocol {
    
    var label = UILabel()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupCollectionViewCell()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

private extension CollectionViewCell {
    
    func setupCollectionViewCell() {
        label.layer.cornerRadius = 3
        setupCell()
        addSubview(label)
        setupLabelConstraints()
    }
    
    func setupCell() { /// настройка теней и фона
        layer.backgroundColor = UIColor.white.cgColor /// если убрать , то не будет фона для тени, и она не будет видна на черном или прозрачном фоне
        layer.cornerRadius = 3
        layer.masksToBounds = false /// позволяет тени отображаться за пределами слоя
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.3 /// непрозрачность тени
        layer.shadowRadius = 0.0 /// радиус размытия тени
        layer.shadowOffset = CGSize(width: 0, height: 1) /// размеры смещения тени относительно слоя
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(labelTapped)))
    }
    
    @objc func labelTapped() { /// обработка нажатия на ячейку/метку
        guard let collectionView = superview as? UICollectionView else { return } /// superview предоставляет доступ к родительскому представлению текущей ячейки. Приводим его к к типу UICollectionView
        collectionView.visibleCells.forEach { $0.backgroundColor = .white } /// visibleCells - массив всех ячеек, которые в данный момент видны на экране. Для всех устанавливается белый цвет фона
        backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0) /// фон текущей ячейки
    }
    
    func setupLabelConstraints() {
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let leading = label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10)
        let trailing = label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        let height = label.heightAnchor.constraint(equalToConstant: bounds.height)

        NSLayoutConstraint.activate([height, leading, trailing])
    }
    
}
