import Foundation

/* 1) Написать класс, ответственный за вычисления.
Класс для инициализации принимает 2 переменных - числа, по умолчанию числа равны нулю. Класс
умеет посредством методов выполнять стандартные арифметические операции - сложение /
вычитание / умножение / деление. Каждая из функций возвращает результат. */


class Calculator {
    private var a: Double
    private var b: Double
    
    init(a: Double = 0, b: Double = 0) {
        self.a = a
        self.b = b
    }
    
    func add () -> Double {
        return a + b
    }
    
    func subtract () -> Double {
        return a - b
    }
    
    func multiply () -> Double {
        return a * b
    }
    
    func divide () -> Double? {
        if b == 0 {
                    return nil
                }
                return a / b
    }
}

var calc = Calculator(a: 15, b: 5)
print(calc.add())
print(calc.subtract())
print(calc.multiply())
print(calc.divide()!)


/* 2) Определить сущности геометрических фигур (например треугольник, квадрат, круг и тд).
Реализовать функцию описания у фигур, реализовать общий класс фигура - который содержит в себе
описание, количество углов, функцию draw() (рисовать не нужно, можно просто вывести в консоль
что-нибудь) - переопределить соотвествующие методы у сабклассов. */


class Figure {
    var description: String
    var angles: Int
    
    init(description: String, angles: Int) {
        self.description = description
        self.angles = angles
    }
    
    func draw () { print("Draw figure with description \(description) and \(angles) angles")}
}


class Triangle: Figure {
    override init(description: String, angles: Int = 3) {
        super.init(description: description, angles: angles)
    }
    
    override func draw() {
        print("Drawing Triangle with \(angles) angles. Triangle description: \(description)")
    }
}

class Circle: Figure {
    override init(description: String, angles: Int = 0) {
        super.init(description: description, angles: angles)
    }
    
    override func draw() {
        print("Drawing Circle with \(angles) angles. Circle description: \(description)")
    }
}

var triangle = Triangle(description: "Triangle is a figure with 3 angles")
var circle = Circle(description: "Circle is a figure with no angles")

triangle.draw()
circle.draw()
