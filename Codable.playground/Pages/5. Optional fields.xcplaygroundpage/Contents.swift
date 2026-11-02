import Foundation

struct User: Codable {
    let id: Int
    let name: String
    let email: String?
}

let jsonData = """
{
  "id": 1,
  "name": "Jack Daniels",
  "email": "daniels@example.com"
}
""".data(using: .utf8)!

let decoder = JSONDecoder()

do {
    let user = try decoder.decode(User.self, from: jsonData)
    print(user)
} catch {
    print("Decoding failed:", error)
}

let jsonData2 = """
{
  "id": 1,
  "name": "Jack Daniels",
}
""".data(using: .utf8)!

do {
    let user = try decoder.decode(User.self, from: jsonData2)
    print(user)
} catch {
    print("Decoding failed:", error)
}
