import Foundation

struct Event: Codable {
    let id: Int
    let title: String
    let date: Date
}

// ISO 8601

let jsonData1 = """
{
  "id": 1,
  "title": "Meeting",
  "date": "2024-12-01T14:30:00Z"
}

""".data(using: .utf8)!

let decoder = JSONDecoder()
decoder.dateDecodingStrategy = .iso8601

do {
    let event1 = try decoder.decode(Event.self, from: jsonData1)
} catch {
    print("Decoding failed:", error)
}

// UNIX timestamp (seconds since 1970)

let jsonData2 = """
{
  "id": 2,
  "title": "Conference",
  "date": 1701431400
}

""".data(using: .utf8)!

let decoder2 = JSONDecoder()
decoder2.dateDecodingStrategy = .secondsSince1970

do {
    let event = try decoder2.decode(Event.self, from: jsonData2)
} catch {
    print("Decoding failed:", error)
}

// UNIX timestamp в миллисекундах

let jsonData3 = """
{
  "id": 3,
  "title": "Workshop",
  "date": 1701431400000
}

""".data(using: .utf8)!

let decoder3 = JSONDecoder()
decoder3.dateDecodingStrategy = .custom { decoder in
    let container = try decoder.singleValueContainer()
    let milliseconds = try container.decode(Double.self)
    return Date(timeIntervalSince1970: milliseconds / 1000)
}

do {
    let event = try decoder3.decode(Event.self, from: jsonData3)
} catch {
    print("Decoding failed:", error)
}

// Кастомный строковый формат даты

let jsonData4 = """
{
  "id": 4,
  "title": "Release",
  "date": "01-12-2024 17:45"
}

""".data(using: .utf8)!

let formatter = DateFormatter()
formatter.dateFormat = "dd-MM-yyyy HH:mm"
formatter.locale = Locale(identifier: "en_US_POSIX")
formatter.timeZone = TimeZone(secondsFromGMT: 0)

let decoder4 = JSONDecoder()
decoder4.dateDecodingStrategy = .formatted(formatter)

do {
    let event = try decoder4.decode(Event.self, from: jsonData4)
} catch {
    print("Decoding failed:", error)
}
