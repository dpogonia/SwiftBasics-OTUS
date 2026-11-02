import Foundation

/*Сгенерировать массив случайных чисел (например 200 чисел). Найти индекс первого повторяющегося числа в массиве. Если все числа разные - то -1.
Пример : [3, 4, 5, 6, 8, 78, 67, 4, 88] - 4, индекс 1

Критерии оценки:
Самостоятельная генерация массива с помощью случайного выбора - 20 баллов.
Правильный возвращаемый индекс повторяющегося числа - 80 баллов. */

var randomArray: [Int] = []
for _ in 0..<200 {
    randomArray.append(Int.random(in: 0..<50))
}


func duplicateFinder(array: [Int]) -> Int {
    var seen = Set<Int>()
    for (index, value) in array.enumerated() {
        if seen.contains(value) {
            return index
        }
        seen.insert(value)
    }
    return -1
}
print(randomArray)
duplicateFinder(array: randomArray)

