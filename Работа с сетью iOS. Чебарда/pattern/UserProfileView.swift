import UIKit

class UserProfileView: UIView {
    
    private var people = [Person]()
    
    init() {
        super.init(frame: .zero)
        setupUserProfileView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

}

private extension UserProfileView {
    
    func setupUserProfileView() {
        backgroundColor = .cyan
        dowloandData()
    }
    
    func dowloandData() {
        guard let url = URL(string: "") else { return } // объявление url
        
        URLSession.shared.dataTask(with: url) { data, _, error in // передача url в dataTask
            
            guard let data = data, error == nil else {
                print("Error dowloanding data:", error ?? "Uknown error")
                return
            }
            // попытка декодирования
            do {
                let decodedData = try JSONDecoder().decode([Person].self, from: data) // в методе decode передаем тип данных, в который должны будут быть декодированы данные, получаемые с JSON (date). В нашем случае мы говорим ПК - попытайся декодировать данные полученные из data
                DispatchQueue.main.async {
                    self.people = decodedData // присвоение данных в массив people
                    // сollectionView.reloadData // обновление всех данных UICollectionView
                    // сollectionView.performBatchUpdates { } // обновленных избранных данных UICollectionView
                    
                }
            } catch {
                print("Error dowloanding data:", error)
            }
        }
    .resume() // необходим для выполнения запроса
        
        /* private let jsonDec = JSONDecoder()
        // JSONDecoder - класс предоставляющий методы для преобразования(декодирования) данных JSON в объекты Swift (структуры или классы).
        jsonDec.keyDecodingStrategy = .convertFromSnakeCase // перевод camelCase в snake_Case для корректного считывания названия JSON */
    }
    
}
