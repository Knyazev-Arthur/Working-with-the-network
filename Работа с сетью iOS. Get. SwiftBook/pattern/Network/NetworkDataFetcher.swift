import Foundation

class NetworkDataFetcher {
    
    private let networkService = NetworkService()
    
    /// метод используется для выполнения запроса по указанному URL-адресу и для декодирования полученных json данных
    /// замыкание response позволяет передавать результат запроса обратно в вызывающий код для дальнейшей обработки
    func fetchTrask(urlString: String, response: @escaping (SearchResponse?) -> Void) {
        
        /// метод request для выполнения асинхронных HTTP-запросов и обработки результатов запроса с помощью замыкания completion, принимающее аргументы
        networkService.request(urlString: urlString) { result in
            switch result { /// switch по результату запроса
            case .success(let data):
                do { /// если удалось
                    /// данные декодируются из JSON в объект типа SearchResponse с помощью JSONDecoder
                    let tracks = try JSONDecoder().decode(SearchResponse.self, from: data)
                    response(tracks) /// объект SearchResponse передается в замыкание response для дальнейшей обработки
                } catch let jsonError { /// в случае ошибки
                    print("Failed to decode JSON", jsonError)
                    response(nil)
                }
                
            case .failure(let error):
                print(error.localizedDescription)
                response(nil)
            }
        }
    }
}
