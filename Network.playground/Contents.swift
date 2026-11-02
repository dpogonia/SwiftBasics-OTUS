import UIKit

//class NetworkManager {
//    
//    nonisolated(unsafe) static var shared = NetworkManager()
//    
//    private init() {
//        NetworkManager.shared = NetworkManager.shared
//    }
//    
//    func fetchData(completion: @escaping (String) -> Void) {
//        DispatchQueue.global().async {
//            // получение данных на глобальной очереди
//            let result = "Полученные данные" // мы получили данные в переменную result
//            // Теперь данные нужно «отправить» наружу через замыкание, которое мы получили в качестве аргумента.
//            DispatchQueue.main.async {
//                completion(result)
//            }
//        }
//    }
//}
//
//NetworkManager.shared.fetchData { print($0) }
//
//class ProfileViewController {
//    
//    var statusLabel: UILabel?
//    
//    
//    func refreshStatus() {
//        NetworkManager.shared.fetchData { [weak self] result in
//            self?.statusLabel?.text = result
//        }
//    }
//}
let jsonData = """
    {
        "name": "Alex",
        "age": 25,
        "is_pro_user": true
    }
    """.data(using: .utf8)!



struct User: Decodable {
    let name: String
    let age: Int
    let isProUser: Bool
    
    enum CodingKeys: String, CodingKey {
        case name
        case age
        case isProUser // Здесь мы связываем "is_pro_user" из JSON с "isProUser" в коде
    }
}

let decoder = JSONDecoder()
decoder.keyDecodingStrategy = .convertFromSnakeCase

do {
    let user = try decoder.decode(User.self, from: jsonData)
    print("Success имя пользователя: \(user.name)")
} catch {
    print("Ошибка десериализации: \(error)")
}

// 1. JSON теперь не опциональный для простоты примера
let jsonData2 = """
{
    "name": "Alex",
    "is_pro_user": true
}
""".data(using: .utf8)!

struct User2: Decodable {
    let name: String
    let age: Int?
    let isProUser: Bool
    
    // Правильное название перечисления — CodingKeys
    enum CodingKeys: String, CodingKey {
        case name
        case age
        case isProUser = "is_pro_user"
    }
}

do {
    // Декодируем данные в модель User
    let user = try decoder.decode(User2.self, from: jsonData2)
    print("Success! Имя пользователя: \(user.age), Pro: \(user.isProUser)")
} catch {
    print("Ошибка десериализации: \(error)")
}
