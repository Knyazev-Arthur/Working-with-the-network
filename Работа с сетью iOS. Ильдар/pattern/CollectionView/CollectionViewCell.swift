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
    
    func setupCell() {
        layer.backgroundColor = UIColor.white.cgColor
        layer.cornerRadius = 3
        layer.masksToBounds = false
        layer.shadowColor = UIColor.gray.cgColor
        layer.shadowOpacity = 0.3
        layer.shadowRadius = 0.0
        layer.shadowOffset = CGSize(width: 0, height: 1)
        addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(labelTapped)))
    }
    
    @objc func labelTapped() { /// обработка нажатия на ячейку/метку
        guard let collectionView = superview as? UICollectionView else { return }
        collectionView.visibleCells.forEach { $0.backgroundColor = .white }
        backgroundColor = UIColor(red: 240/255, green: 240/255, blue: 240/255, alpha: 1.0)
    }
    
    func setupLabelConstraints() {
        label.translatesAutoresizingMaskIntoConstraints = false
        
        let leading = label.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10)
        let trailing = label.trailingAnchor.constraint(equalTo: trailingAnchor, constant: -10)
        let height = label.heightAnchor.constraint(equalToConstant: bounds.height)

        NSLayoutConstraint.activate([height, leading, trailing])
    }
    
}
