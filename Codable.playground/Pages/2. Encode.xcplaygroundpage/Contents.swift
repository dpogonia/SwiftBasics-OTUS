import Foundation

struct User: Codable {
    let id: Int
    let name: String
    let email: String
}

/*:
 ## Кодирование модели → JSON
 
 POST / PUT запросы
 сохранение модели в файл
 отправка аналитики
*/
let user = User(
    id: 1,
    name: "Jack Daniels",
    email: "daniels@example.com"
)

let encoder = JSONEncoder()
encoder.outputFormatting = .prettyPrinted //для удобства просмотра при отладке

let data = try encoder.encode(user) //возвращает Data
let jsonString = String(data: data, encoding: .utf8)
