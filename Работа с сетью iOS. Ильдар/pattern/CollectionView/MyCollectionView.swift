import UIKit

// MARK: MyCollectionViewProtocol
protocol MyCollectionViewProtocol: UICollectionView {
    var viewController: ViewController? { get set }
    var dataSourc: [Post] { get set }
}

class MyCollectionView: UICollectionView, MyCollectionViewProtocol {
    
    var dataSourc = [Post]()
    weak var viewController: ViewController?
    private let collectionViewDatasource = CollectionViewDataSource()
    private let layout = UICollectionViewFlowLayout()
    
    
    init() {
        super.init(frame: .zero, collectionViewLayout: layout)
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func didMoveToSuperview() {
        
    }
    
}

private extension MyCollectionView {
    
    func setupCollectionView() {
        register(CollectionViewCell.self, forCellWithReuseIdentifier: "\(CollectionViewCell.self)")
        backgroundColor = .white
        
        dataSource = collectionViewDatasource
        collectionViewDatasource.myCollectionView = self

        setupLayout()
    }
    
    func setupLayout() { /// настройка внешнего вида ячейки
        layout.scrollDirection = .vertical /// формат расположения ячеек при скроллинге
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 35)
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        layout.minimumInteritemSpacing = 0
    }
    
    /// при работе с запросами мы можем закешировать полученные данные по URL
    // UIApplication.shared.canOpenURL(url) /// проверка интернет URL адреса на валидность
    // sessionConfiguration.timeoutIntervalForRequest /// максимальное время ожидания (в секундах) для запроса перед тем, как он будет считаться неудавшимся из-за тайм-аута
    // sessionConfiguration.timeoutIntervalForResource /// максимальное время ожидания (в секундах) для получения всех ресурсов для запроса, таких как данные или заголовки, перед тем, как он будет считаться неудавшимся из-за тайм-аута
    
}
