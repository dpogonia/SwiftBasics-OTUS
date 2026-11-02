protocol Notificator {
    func send(message: String)
}



class FacebookNotificator: Notificator {
    private let wrapee: Notificator // Внутренняя матрешка

    init(parent: Notificator) {
        wrapee = parent
    }

    func send(message: String) {
        print("Sent to facebook : \(message)")
        wrapee.send(message: message)
    }
}

class SlackNotificator: Notificator {
    private let wrapee: Notificator // Внутренняя матрешка

    init(parent: Notificator) {
        wrapee = parent
    }

    func send(message: String) {
        print("Sent to Slack : \(message)")
        wrapee.send(message: message)
    }
}

class EmailNotificator: Notificator {
    func send(message: String) {
        print("Sent to email : \(message)")
    }
}

var facebook = true
var slack = false

var stack: Notificator = EmailNotificator()

if facebook {
    stack = FacebookNotificator(parent: stack)
}

if slack {
    stack = SlackNotificator(parent: stack)
}


stack.send(message: "Alert")

