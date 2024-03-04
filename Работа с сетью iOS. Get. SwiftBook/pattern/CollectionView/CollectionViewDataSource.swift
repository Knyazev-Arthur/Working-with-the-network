import UIKit

// MARK: CollectionViewDataSourceProtocol
protocol CollectionViewDataSourceProtocol {
    var myCollectionView: MyCollectionViewProtocol? { get set }
}

class CollectionViewDataSource: NSObject, UICollectionViewDataSource, CollectionViewDataSourceProtocol {
    
    weak var myCollectionView: MyCollectionViewProtocol?
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        myCollectionView?.searchResponce?.results.count ?? 0
    }
    
    /// метод используется для настройки и возвращения ячейки, которая будет отображаться в коллекции для определенного индекса позиции
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        /// метод используется для получения повторно используемой ячейки для указанного идентификатор
        /// withReuseIdentifier - идентификатор ячейки, который был зарегистрирован для повторного использования
        /// indexPath - индекс позиции, для которой нужно получить ячейку
        /// приводим возвращенную ячейку к типу CollectionViewCell, т.к. он являетя главным представлением и нам нужны его свойства
        guard let itemCell = collectionView.dequeueReusableCell(withReuseIdentifier: "\(CollectionViewCell.self)", for: indexPath) as? CollectionViewCell else { return UICollectionViewCell() }
        
        /// извлекаем трек из массива результатов поиска и устанавливаем имя трека в метку ячейки перед возвращением этой ячейки для отображения
        /// searchResponce свойство MyCollectionView, содержащее ответ от сервера на запрос поиска
        let track = myCollectionView?.searchResponce?.results[indexPath.row]
        itemCell.label.text = track?.trackName
        return itemCell
    }
    

}
