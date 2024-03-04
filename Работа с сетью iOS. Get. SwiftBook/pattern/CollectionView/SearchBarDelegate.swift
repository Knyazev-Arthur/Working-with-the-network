import UIKit

/// делегат для поискового бара, который реагирует на изменения текста поиска
class SearchBarDelegate: NSObject, UISearchBarDelegate {
    
    private let networkDataFetcher = NetworkDataFetcher()
    weak var myCollectionView: MyCollectionViewProtocol?
    var timer = Timer()
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        /// формируем URL запроса
        let urlString = "https://itunes.apple.com/search?term=\(searchText)&limit=5"
        
        timer.invalidate()
        /// обертка метода в таймер для того, чтобы поиск срабатывал только после того, как пользователь как-бы закончит поисковый ввод спустя 0.5 сек.
        //timer = Timer.scheduledTimer(withTimeInterval: 0.5, repeats: false) { [ weak self ] _ in
            /// метод fetchTrask объекта networkDataFetcher выполняет асинхронный запрос по указанному URL-адресу
            networkDataFetcher.fetchTrask(urlString: urlString) { [weak self] searchResponse in /// замыкание, передаваемое в метод fetchTrask в качестве аргумента
                guard let searchResponse = searchResponse else { return } /// если результат запроса != nil, значит он удался
                self?.myCollectionView?.searchResponce = searchResponse /// результат запроса присваивается свойству searchResponce объекта myCollectionView, что позволяет обновить данные в коллекции с новыми результатами поиска
                self?.myCollectionView?.reloadData() /// обновляем отображение коллекции с учетом новых данных
            }
        //}
        
    }
    

}

func getData(_ url: String, _ completion: () -> Void) {
    print("Some work")
    completion()
}

