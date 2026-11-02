/*:
 ## Декодирование JSON → модель
*/

import Foundation

struct User: Codable {
    let id: Int
    let name: String
    let email: String
}

let jsonData = """
{
  "id": 1,
  "name": "Jack Daniels",
  "email": "daniels@example.com"
}
""".data(using: .utf8)!

let decoder = JSONDecoder()

let user = try decoder.decode(User.self, from: jsonData)

/*:
 ### работа с типичными ошибками
*/

let jsonData2 = """
{
  "id": "1",
  "name": "Jack Daniels",
  "email": "daniels@example.com"
}
""".data(using: .utf8)!

do {
    let user = try decoder.decode(User.self, from: jsonData2)
    print(user)
} catch {
    print("Decoding failed:", error)
}

let jsonData3 = """
{
  "name": "Jack Daniels",
  "email": "daniels@example.com"
}
""".data(using: .utf8)!

do {
    let user = try decoder.decode(User.self, from: jsonData3)
    print(user)
} catch {
    print("Decoding failed:", error)
}
