import Foundation

struct User: Decodable {
    let id: Int
    let name: String
    let isAdult: Bool
    let hasChildren: Bool?

    private enum CodingKeys: String, CodingKey {
        case id
        case name
        case age
        case hasChildren
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)

        id = try container.decode(Int.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)

        let age = try container.decode(Int.self, forKey: .age)
        isAdult = age >= 18
        
        hasChildren = try container.decodeIfPresent(Bool.self, forKey: .hasChildren)
    }
}

let jsonData = """
{
  "id": 1,
  "name": "Jack Daniels",
  "age": 21
}
""".data(using: .utf8)!

let decoder = JSONDecoder()

let user = try decoder.decode(User.self, from: jsonData)
