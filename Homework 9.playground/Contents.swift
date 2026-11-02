import UIKit


// MARK: ЗАДАНИЕ 1. Верный ли приведенный ниже код, если нет, то где. ОТВЕТ: weak self нужно вынести в кложуру DispatchWorkItem. Сам решить первую задачу не смог, воспользовался помощью.

final class ViewController: UIViewController {
  
     var workItem: DispatchWorkItem?
      
     func execute() {
         let workItem = DispatchWorkItem { [weak self] in
             UIView.animate(withDuration: 1) { // [weak self] in // тут можно без weak
                 
                 //1. ViewController указывает сильной ссылкой на workItem через свойство var workItem: DispatchWorkItem?
                 //2. workItem сильно держит замыкание DispatchWorkItem.
                 //3. Функция UIView.animate()  держит self то есть ViewController.
                 // Чтобы разорвать цикл, нужно сделать хотя бы одну ссылку не сильной. Тогда замыкание workItem больше не удерживает контроллер в памяти, и когда контроллер уходит (например, его закрыли), ARC может его корректно деинициализировать. weak self внутри UIView.animate не решает проблему цикла, потому что удерживает self именно внешнее замыкание workItem - поэтому добавил weak self сверху, а старое закомментил. 
                 self?.view.alpha = 0.1
             }
         }
  
         self.workItem = workItem
     }
    deinit { print("Class ViewController deinit") } // проверка деинитом
  
 }
  
 autoreleasepool {
     let vc = ViewController()
     vc.execute()
 }

// MARK: ЗАДАНИЕ 2. Где в задании находится утечка памяти, объясните свой выбор. ОТВЕТ: в кложуре нет weak self

struct Struct1 { // дополнил структурой Struct1, иначе ошибка ниже.
    var closure: (() -> Void)?
}


class Class1 {
  
     var property: Int = 3
     var struct1 = Struct1()
  
     func execute() {
         struct1.closure = { [weak self] in // добавил weak self
             self?.property = 2 // тут + weak дает опционал, так что нужно добавить ? для его проверки
         }
     }
    
    deinit { print("Class1 deinit") }
  
 }
  
 autoreleasepool {
     var s: Class1? = Class1()
     s?.execute()
     s = nil
 }

 // Class1 содержит struct1 как свойство. Замыкание, которое присваивается struct1.closure, сильно захватывает self (то есть Class1), потому что нет weak self. Поскольку closure хранится как свойство struct1, а struct1 сам хранится как свойство Class1, получается ссылка друг на друга: Class1 сильно ссылается на struct1 как свое свойство. closure внутри struct1 сильно держит self то есть Class1, что создает retain cycle. Нужно добавить [weak self] в кложуру, чтобы разорвать.


