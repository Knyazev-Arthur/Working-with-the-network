import UIKit

class NetworkService {
    
    /// метод выполнения асинхронных HTTP-запросов и обработки результатов запроса с помощью замыкания completion
    func request(urlString: String, completion: @escaping (Result <Data, Error>) -> Void) {
        guard let url = URL(string: urlString) else { return } /// создае объекта URL
        
        /// асинхронный запрос с использованием URLSession.shared.dataTask(with:completionHandler:) - метод создает задачу для загрузки данных из указанного URL-адреса
        /// после завершения запроса вызыв-ся обработчик завершения (completion handler), передаваемый методу dataTask
        let configuration = URLSessionConfiguration()
        configuration.
        URLSession(configuration: <#T##URLSessionConfiguration#>)
        URLSession.shared.dataTask(with: url) { data, _, error in
            DispatchQueue.main.async { /// выполнение задачи на главной очереди асинхронным методом
                if let error = error {
                    completion(.failure(error)) /// перечисление Result в случае ошибки
                    return
                }
                guard let data = data else { return }
                completion(.success(data)) /// перечисление Result в случае получения данных, доступ к которым будет предоставлен вызывающему коду
            }
        }.resume() ///  для запуска задачи
        
    }
    
}
