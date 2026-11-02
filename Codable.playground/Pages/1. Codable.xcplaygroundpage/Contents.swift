
//:  # Codable

/*:
 Большинство мобильных приложений:
 получают данные с сервера (JSON),
 отправляют данные на сервер,
 сохраняют данные локально.
 Любой из этих сценариев — это преобразование данных:
 из байтов (Data) в Swift-объекты,
 и обратно.
 */

import Foundation

typealias Codable = Encodable & Decodable

/*:
 Encodable - Сериализация — преобразование модели в данные
 
 Decodable - Десериализация — преобразование данных в модель
*/

struct User: Codable {
    let id: Int
    let name: String
    let email: String
}
/*:
 Swift автоматически генерирует:
 
 * init(from decoder: Decoder)
 
 * encode(to encoder: Encoder)
 
 Условия автогенерации:
 
 * все свойства — Codable
 
 * нет кастомных init(from:)
 
 * нет кастомного encode(to:)
 
*/
