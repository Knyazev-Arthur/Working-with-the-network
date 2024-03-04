import UIKit

class UserProfileView: UIView {
    
    private let getButton = UIButton()
    private let postButton = UIButton()
    private let urlString = "https://jsonplaceholder.typicode.com/posts"

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
        backgroundColor = .black
        setupGetButton()
        setupPostButton()
        addSubview(getButton)
        addSubview(postButton)
        setupGetButtonConstraints()
        setupPostButtonConstraints()
        
    }
        
    func setupGetButton() {
        getButton.setTitle("GET", for: .normal)
        getButton.addTarget(self, action: #selector(tapGetButton), for: .touchUpInside)
    }
    
    // MARK: GET запрос
    @objc func tapGetButton() {
        guard let url = URL(string: urlString) else { return }
        let session = URLSession.shared // создание сессии запроса
        
        /* data - запрашиваемые данные
         response - глобальный ответ на наш запрос, в нем коды запросы, основная http информация
         error - ошибка, если что-то пошло не так */
        session.dataTask(with: url) { data, response, error in
            if let response = response {
                print("--------------------------------------\nRESPONSE\n\(response)\n--------------------------------------")
            }
            
            guard let data = data else { return }
            print("--------------------------------------\nDATA\n\(data)\n--------------------------------------")
            
            do { // JSONSerialization - класс, который предоставляет функциональность для преобразования данных из формата JSON в объекты Swift и обратно
                let json = try JSONSerialization.jsonObject(with: data, options: []) // метод преобразует данные JSON в объекты Swift (NSDictionary, NSArray).
                print("--------------------------------------\nJSON\n\(json)\n--------------------------------------")
            } catch {
                print("--------------------------------------\nERROR\n\(error)\n--------------------------------------")
            }
            
        }.resume() // запуск метода
    }
    
    func setupPostButton() {
        postButton.setTitle("POST", for: .normal)
        postButton.addTarget(self, action: #selector(tapPostButton), for: .touchUpInside)
    }
    
    // MARK: POST запрос
    @objc func tapPostButton() {
        guard let url = URL(string: urlString) else { return }
        let parameters = ["username" : "ivan", "message" : "Hello Steve!"] // параметры для отправки
        var request = URLRequest(url: url) // создание запроса
        request.addValue("application/json", forHTTPHeaderField: "Content-Type") // Заголовок "Content-Type" в HTTP запросах используется для указания типа содержимого (контента), который отправляется или принимается в теле запроса или ответа. В случае использования "application/json" в качестве значения этого заголовка, сервер понимает, что данные в теле запроса или ответа представлены в формате JSON.
        request.httpMethod = "POST" // обозначение метода
        guard let httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: []) else { return } // метод, который преобразует объекты Swift (NSDictionary, NSArray) в строку JSON
        request.httpBody = httpBody // установка тела запроса
        
        let session = URLSession.shared
        
        session.dataTask(with: request) { data, response, error in
            if let response = response {
                print("--------------------------------------\nRESPONSE\n\(response)\n--------------------------------------")
            }
            
            guard let data = data else { return }
            print("--------------------------------------\nDATA\n\(data)\n--------------------------------------")
            
            do { // JSONSerialization - класс, который предоставляет функциональность для преобразования данных из формата JSON в объекты Swift и обратно
                let json = try JSONSerialization.jsonObject(with: data, options: []) // метод преобразует данные JSON в объекты Swift (NSDictionary, NSArray).
                print("--------------------------------------\nJSON\n\(json)\n--------------------------------------")
            } catch {
                print("--------------------------------------\nERROR\n\(error)\n--------------------------------------")
            }
            
        }.resume()
    }
    
    func setupGetButtonConstraints() {
        getButton.translatesAutoresizingMaskIntoConstraints = false
        
        let centerX = getButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        let centerY = getButton.centerYAnchor.constraint(equalTo: centerYAnchor)
        
        NSLayoutConstraint.activate([centerX, centerY])
    }
    
    func setupPostButtonConstraints() {
        postButton.translatesAutoresizingMaskIntoConstraints = false
        
        let centerX = postButton.centerXAnchor.constraint(equalTo: centerXAnchor)
        let top = postButton.topAnchor.constraint(equalTo: getButton.bottomAnchor, constant: 16)
        
        NSLayoutConstraint.activate([top, centerX])
    }
}
