import UIKit

class ViewController: UIViewController {
    
    private let myCollectionView = MyCollectionView()
    
    init() {
        /// параметры nibName и bundle используются для инициализации контроллера с использованием файла интерфейса (XIB файла) вместо программного создания представления
        super.init(nibName: nil, bundle: nil)
        myCollectionView.viewController = self /// позволяем MyCollectionView знать о своем контроллере.
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    /// метод вызывается, когда представление контроллера еще не установлено
    override func loadView() {
        view = myCollectionView /// установливаем myCollectionView в качестве корневого и единственного представления контроллера
    }

}
