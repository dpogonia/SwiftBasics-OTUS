import Foundation

/* Описание/Пошаговая инструкция выполнения домашнего задания:
 
1. Есть произвольный массив чисел, найти максимальное и минимальное число и поменять их местами

2. Есть две коллекции символов - собрать результирующее множество из символов, что повторяются в 2х коллекциях
 
3. Создать словарь с соотношением имя (ключ) пользователя - пароль (значение), получить из словаря все имена, пароли которых длиннее 10 символов

 Задачи рекомендуется делать в Playground */

// Ответ на задачу 1.

var arr: [Int] = [1, 0, 5, 3, 8, 7, 7, 9, 10, 11, 14, 13, 14, 16, 16, 17, 50, 18, 19, 20]

var minIndex = 0
var maxIndex = 0

for i in 0 ..< arr.count {
    if arr[i] < arr[minIndex] { minIndex = i }
    if arr[i] > arr[maxIndex] { maxIndex = i }
    
}

arr.swapAt(minIndex, maxIndex)
print(arr)

// Ответ на задачу 2.

var set1: Set = [1, 3, 4, 5, 7, 9]
var set2: Set = [0, 3, 5, 11, 13, 17, 19]

var intersectSet: Set = set1.intersection(set2)
print(intersectSet)

// Ответ на задачу 3

var accessDict: [String: String] = ["user1": "123456jfhdhflsah", "user2": "111111dfddfdfsa", "user3": "222222dfdfafkash", "user4": "333333dfasfsfk", "user5": "oiuewop", "user6": "555555f", "user7": "66666f6", "user8": "f777777"]
var longPasswordKeys: [String] = []

for (key, value) in accessDict {
    if value.count > 10 {
        longPasswordKeys.append(key)
    }
}

print(longPasswordKeys)








