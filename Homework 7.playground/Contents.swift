import Foundation

/*
Описание/Пошаговая инструкция выполнения домашнего задания:
Для выполнения рекомендуется использовать playground

Написать перечисление, содержащее в себе устройства apple (для упрощения можно взять 5-7 устройств, включающий iPhone, iPad), перечисление должно поддерживать протокол CustomStringConvertible (https://developer.apple.com/documentation/swift/customstringconvertible) и выводить свое описание, также должны быть реализованы свойства:

размер экрана в пикселях (можно использовать CGSize структуру или написать свою - с height width параметрами)
булевая (Bool) переменная отвечающая iPad это или нет */

enum AppleGadgets: CustomStringConvertible {
    case iPhone
    case iPad
    case macBook
    case iWatch
    case appleTV
    
    var screenSize: CGSize {
        switch self {
        case .iPhone: return CGSize(width: 2556, height: 1179)
        case .iPad: return CGSize(width: 1024, height: 768)
        case .macBook: return CGSize(width: 1440, height: 900)
        case .iWatch: return CGSize(width: 42, height:375)
        case .appleTV: return CGSize(width: 1920, height: 1080)
        }
    }
    
    var isIPad: Bool {
        switch self {
        case .iPhone: return false
        case .iPad: return true
        case .macBook: return false
        case .iWatch: return false
        case .appleTV: return false
        }
    }
    
    var description: String {
        let size = screenSize
        let type = isIPad ? "это iPad" : "это не iPad"
        return "\(self) — \(Int(size.width))x\(Int(size.height)) px, \(type)"
    }
}

let device = AppleGadgets.iPhone
print(device)
