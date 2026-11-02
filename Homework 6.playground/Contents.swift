import Foundation

// Описание/Пошаговая инструкция выполнения домашнего задания:
/*Реализовать модель данных пользователя - структуру (с 2-3 полями), создать массив пользователей, сделать какое-то поля (например - имя) - изменяемым.
Создать массив пользователей (3-4 элемента), вывести в консоль описание пользователя, поменять имя для второго пользователя в массиве, снова вывести описание для каждого пользователя.

Критерии оценки:
Реализация модели данных - 20 баллов.
Вывод описания пользователей массива в консоль - 20 баллов.
Изменение данных и повторный вывод - 60 баллов. */


struct User {
    var firstName: String // изменяемое поле
    let lastName: String
    let middleName: String?
    lazy var fullName: String = {
        "\(firstName) \(lastName)"
    }()
    var age: Int // изменяемое поле
    
    func description () {
        print("\(firstName) \(String(middleName ?? "")) \(lastName) is \(age) y.o.")
    }
}

var users: [User] = [User(firstName: "Samuel", lastName: "Jackson", middleName: "L.", age: 20), User(firstName: "Sergei", lastName: "Petrov", middleName: "Ivanovich", age: 30), User(firstName: "Boris", lastName: "Britva", middleName: nil, age: 40)] // Создать массив пользователей

print(users[0].description()) // Вывести в консоль описание пользователя

users[1].firstName = "Lev" // Поменять имя для второго пользователя в массиве

for user in users {
    print(user.description())
} // снова вывести описание для каждого пользователя

