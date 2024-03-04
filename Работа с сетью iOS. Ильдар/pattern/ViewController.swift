import UIKit

class ViewController: UIViewController {
    
    private let myCollectionView = MyCollectionView()
    
    init() {
        super.init(nibName: nil, bundle: nil)
        myCollectionView.viewController = self
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = myCollectionView
    }

}
