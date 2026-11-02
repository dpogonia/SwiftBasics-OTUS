import Foundation

struct Post: Codable {
    let id: Int
    let title: String
}

struct User: Codable {
    let id: Int
    let name: String
    let posts: [Post]
}

let jsonData = """
{
  "id": 1,
  "name": "Jack Daniels",
  "posts": [
    {
      "id": 101,
      "title": "Understanding Codable"
    }
  ]
}

""".data(using: .utf8)!

let decoder = JSONDecoder()

let user = try decoder.decode(User.self, from: jsonData)

//https://app.quicktype.io/ - автогенерация моделей
