import Foundation

let jsonData = """
{
  "user_id": 1,
  "user_name": "Jack Daniels",
  "email": "daniels@example.com"
}
""".data(using: .utf8)!

struct User: Codable {
    let id: Int
    let name: String
    let email: String
    
    enum CodingKeys: String, CodingKey {
        case id = "user_id"
        case name = "user_name"
        case email = "email"
    }
}

let decoder = JSONDecoder()

do {
    let user = try decoder.decode(User.self, from: jsonData)
    print(user)
} catch {
    print("Decoding failed:", error)
}

/*:
 ### автоматический .convertFromSnakeCase
*/

struct User2: Codable {
    let userId: Int
    let userName: String
    let email: String
}

let decoder2 = JSONDecoder()
decoder.keyDecodingStrategy = .convertFromSnakeCase //зеркально encoder.keyEncodingStrategy = .convertToSnakeCase

do {
    let user = try decoder.decode(User2.self, from: jsonData)
    print(user)
} catch {
    print("Decoding failed:", error)
}
