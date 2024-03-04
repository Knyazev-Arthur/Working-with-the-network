import UIKit

// MARK: CollectionViewDataSourceProtocol
protocol CollectionViewDataSourceProtocol {
    var myCollectionView: MyCollectionViewProtocol? { get set }
}

class CollectionViewDataSource: NSObject, UICollectionViewDataSource, CollectionViewDataSourceProtocol {
    
    weak var myCollectionView: MyCollectionViewProtocol?
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        myCollectionView?.dataSourc.count ?? 0
    }
    
    /// метод используется для настройки и возвращения ячейки, которая будет отображаться в коллекции для определенного индекса позиции
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let itemCell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(CollectionViewCell.self)", for: indexPath) as? CollectionViewCell else { return UICollectionViewCell() }
        guard let post = myCollectionView?.dataSourc[indexPath.row] else { return UICollectionViewCell() }
        itemCell.label.text = "\(post.title) \(post.body)"
        return itemCell
    }
    

}
