import UIKit

class NetworkManager {
    
    private let sessionConfiguration = URLSessionConfiguration.default
    private let session = URLSession.shared
    private let decoder = JSONDecoder()
    
    func obtainPosts() {
        
        guard let url = URL(string: "https://jsonplaceholder.typicode.com/posts") else { return } /// для системы url формален, т.е. он может воспринять его как путь к файлу
        /// data - запрашиваемые данные
        /// response - глобальный ответ на наш запрос, в нем коды запросы, основная http информация
        /// error - ошибка, если что-то пошло не так
        session.dataTask(with: url) { data, response, error in
            if error == nil, let parsData = data {
                guard let posts = try? self.decoder.decode([Post].self, from: parsData) else { return }
                
            } else {
                print("Error:", error?.localizedDescription) /// localizedDescription - локализованная информация об ошибке
            }
        }.resume() /// активация запроса
    }
}
