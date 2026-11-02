import UIKit

protocol SendMessage {
    func sendPhoto()
    func sendText()
}

class SendTelegram: SendMessage {
    func sendPhoto() {
        print("фото, аддаптированное под телеграмм")
    }
    
    func sendText() {
        print("текст, аддаптированный под телеграмм \n")
    }
    
}

class SendWhatsapp: SendMessage {
    func sendPhoto() {
        print("фото, аддаптированное под ватсапп")
    }
    
    func sendText() {
        print("текст, аддаптированный под ватсапп \n")
    }
    
}

class Messenger {
    private var messege: SendMessage
    
    init(_ currentMessenger: SendMessage) {
        messege = currentMessenger
    }
    
    func changeMessenger(_ newMessenger: SendMessage) {
        messege = newMessenger
    }
    
    func sendMassege() {
        messege.sendPhoto()
        messege.sendText()
    }
}

let telegram = SendTelegram()
let whatsUp = SendWhatsapp()


let messege = Messenger(whatsUp)
messege.sendMassege()

//Time

messege.changeMessenger(telegram)
messege.sendMassege()
