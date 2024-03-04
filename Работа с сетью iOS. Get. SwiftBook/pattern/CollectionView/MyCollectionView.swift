import UIKit

// MARK: MyCollectionViewProtocol
protocol MyCollectionViewProtocol: UICollectionView {
    var viewController: ViewController? { get set }
    var searchResponce: SearchResponse? { get set }
}

class MyCollectionView: UICollectionView, MyCollectionViewProtocol {
    
    var searchResponce: SearchResponse? = nil /// свойство для хранения данных поиска
    weak var viewController: ViewController?
    
    private let collectionViewDatasource = CollectionViewDataSource()
    private let searchBarDelegate = SearchBarDelegate()
    private let searchController = UISearchController(searchResultsController: nil)
    private let layout = UICollectionViewFlowLayout() /// используется для определения расположения и размеров ячеек в коллекции (макет для ячеек)
    
    init() {
        /// super.init: создает экземпляр коллекционного представления
        /// .zero указывает на то, что коллекционное представление будет создано без начального размера и положения
        /// layout - указываем коллекции использовать данный макет для определения внешнего вида и расположения ячеек
        super.init(frame: .zero, collectionViewLayout: layout)
        setupCollectionView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /// вызывается после добавления вьюхи в иерархию представлений модели приложения
    override func didMoveToSuperview() {
        viewController?.navigationItem.searchController = searchController
        viewController?.navigationController?.navigationBar.prefersLargeTitles = true /// увеличение размера текста в navigation баре
        viewController?.title = "Search"
    }
    
}

private extension MyCollectionView {
    
    func setupCollectionView() {
        register(CollectionViewCell.self, forCellWithReuseIdentifier: "\(CollectionViewCell.self)")
        backgroundColor = .white
        
        dataSource = collectionViewDatasource
        collectionViewDatasource.myCollectionView = self /// позволяем collectionViewDatasource знать о своем представлении, что необходимо для обновления данных в текущем представлении, реализация которого происходит с помощью методов и делегатов протокола UICollectionViewDataSource
        
        setupSearchController()
        setupLayout()
    }
    
    func setupSearchController() { /// настройка внешнего вида поискового контроллера
        searchController.searchBar.delegate = searchBarDelegate /// делегат для поискового бара, который реагирует на изменения текста поиска
        searchBarDelegate.myCollectionView = self
        searchController.obscuresBackgroundDuringPresentation = false /// выкл затемнение фона при поиске
    }
    
    func setupLayout() { /// настройка внешнего вида ячейки
        layout.scrollDirection = .vertical /// формат расположения ячеек при скроллинге
        layout.itemSize = CGSize(width: UIScreen.main.bounds.width, height: 35) /// ширина и высота ячейки
        layout.sectionInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0) /// отступы ячейки
        layout.minimumInteritemSpacing = 0 /// расстояние между ячейками по горизонтали
    }
    
}
