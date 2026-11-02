import UIKit

/*
 В Playground реализуйте некоторый базовый класс из выбранной вами области описания (тематики).
 
 Добавьте в него свойства и методы, а также несколько инициализаторов. Класс должен содержать свойства и методы разной области видимости (private, fileprivate, internal или public)
 
 Создайте несколько классов-наследников. Переопределите при необходимости свойства и методы родителя. А также добавьте свои.
 
 В основном пространстве Playground создайте функцию для демонстрации полиморфизма.
 
 Критерии оценки:
 Реализация класса и его свойств/методов - 40 баллов.
 Создание классов наследников - 20 баллов.
 Переопределить свойства и методы родителя - 20 баллов.
 Функция, демонстрирующая полиморфизм - 20 баллов.
 */

class Athlete {
    // MARK: Свойства разной области видимости.
    
    // Internal свойства (можно достать из другого файла в проекте)
    var firstName: String
    var lastName: String
    var age: Int?
    var country: String?
    
    // Вычисляемое свойство. Также Internal.
    var fullName: String {
        "\(firstName) \(lastName)"
    }
    
    // Private. Только для внутренней логики.
    private var trainingHoursPerWeek: Int = 0
    
    // Fileprivate. Доступно внутри файла.
    fileprivate var internalID: UUID
    
    // MARK: Методы
    
    // Internal методы.
    func walk() {
        print("\(fullName) is walking")
    }
    
    func run() {
        print("\(fullName) is running")
    }
    
    // Используем приватное свойство trainingHoursPerWeek.
    func addTraining(hours: Int) {
        trainingHoursPerWeek += hours
        print("\(fullName) trained \(hours) hours, total: \(trainingHoursPerWeek)")
    }
    
    // Публичный метод.
    public func info() {
        print("Athlete: \(fullName), age: \(age ?? 1), country: \(country ?? "Unknown")")
    }
    
    // MARK: - Инициализаторы
    
    // Основной designated инициализатор
    init(firstName: String, lastName: String, age: Int?, country: String?, internalID: UUID, fullName: String) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
        self.country = country
        self.internalID = internalID
    }
    
    // Удобный инициализатор только с именем
    convenience init(firstName: String, lastName: String) {
        self.init(firstName: firstName,
                  lastName: lastName,
                  age: nil,
                  country: nil,
                  internalID: UUID(),
                  fullName: "\(firstName) \(lastName)")
    }
    
    // Failable инициализатор (может вернуть nil)
    init?(firstName: String, lastName: String, age: Int, country: String, internalID: UUID ) {
        guard !firstName.isEmpty, !lastName.isEmpty, age >= 0, age <= 120 else {
            return nil
        }
        
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
        self.country = country
        self.internalID = internalID
    }
    
    // Required инициализатор (обязательный для всех подклассов)
    required init(firstName: String) {
        self.firstName = ""
        self.lastName = ""
        self.age = nil
        self.country = nil
        self.internalID = UUID()
    }
    
    // Дефолтный инит автоматически генерируется, если все свойства инициализированы
}

class Runner: Athlete {
    var best100mTime: Double
    
    override var fullName: String {
        "Runner: \(super.fullName)"
    }
    
    override func run() {
        print("\(fullName) is sprinting!")
    }
    
    func compete(distance: Int) {
        print("\(fullName) runs \(distance) meters")
    }
    
    // Designated init
    init(firstName: String,
         lastName: String,
         age: Int?,
         country: String?,
         best100mTime: Double) {
        self.best100mTime = best100mTime
        super.init(firstName: firstName,
                   lastName: lastName,
                   age: age,
                   country: country,
                   internalID: UUID(),
                   fullName: "\(firstName) \(lastName)")
    }
    
    required init(firstName: String) {
        self.best100mTime = 15.0
        super.init(firstName: firstName)
    }
}


class Boxer: Athlete {
    var weightClass: String
    
    override var fullName: String {
        "Boxer: \(super.fullName)"
    }
    
    override func run() {
        print("\(fullName) is running and boxing")
    }
    
    func punch() {
        print("\(fullName) throws a punch!")
    }
    
    init(firstName: String,
         lastName: String,
         age: Int?,
         country: String?,
         weightClass: String) {
        self.weightClass = weightClass
        super.init(firstName: firstName,
                   lastName: lastName,
                   age: age,
                   country: country,
                   internalID: UUID(),
                   fullName: "\(firstName) \(lastName)")
    }
    
    required init(firstName: String) {
        self.weightClass = "Lightweight"
        super.init(firstName: firstName)
    }
}

class Swimmer: Athlete {
    var swimStyle: String
    
    override var fullName: String {
        "Swimmer: \(super.fullName)"
    }
    
    override func run() {
        print("\(fullName) prefers swimming instead of running")
    }
    
    func swim(distance: Int) {
        print("\(fullName) swims \(distance) meters \(swimStyle)")
    }
    
    init(firstName: String,
         lastName: String,
         age: Int?,
         country: String?,
         swimStyle: String) {
        self.swimStyle = swimStyle
        super.init(firstName: firstName,
                   lastName: lastName,
                   age: age,
                   country: country,
                   internalID: UUID(),
                   fullName: "\(firstName) \(lastName)")
    }
    
    required init(firstName: String) {
        self.swimStyle = "Freestyle"
        super.init(firstName: firstName)
    }
}

// MARK: - Функция для демонстрации полиморфизма

func demonstratePolymorphism(_ athletes: [Athlete]) {
    for athlete in athletes {
        athlete.info()
        athlete.run()   // полиморфная функция, измененная для каждого субкласса
        print("-----")
    }
}

// Примеры

let runner = Runner(firstName: "Usain", lastName: "Bolt", age: 35, country: "Jamaica", best100mTime: 9.58)
let boxer = Boxer(firstName: "Mike", lastName: "Tyson", age: 40, country: "USA", weightClass: "Heavyweight")
let swimmer = Swimmer(firstName: "Michael", lastName: "Phelps", age: 36, country: "USA", swimStyle: "Butterfly")
let generic = Athlete(firstName: "Leo", lastName: "Messi")

let athletes: [Athlete] = [runner, boxer, swimmer, generic]

demonstratePolymorphism(athletes)
