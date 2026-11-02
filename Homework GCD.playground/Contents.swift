import UIKit

/*
 
 Домашнее задание
 Познакомиться с многопоточностью
 Цель:
 попрактиковаться в решении задач по многопоточности с GCD;
 решить ряд задач для усвоения теории.

 Описание/Пошаговая инструкция выполнения домашнего задания:
 
 Исследуйте код ниже и напишите, какие цифры должны вывестись в консоль, обьясните своими словами, почему именно такая последовательность по шагам.

 func testQueue(){ print("1") DispatchQueue.main.async { print("2") DispatchQueue.global(qos: .background).sync { print("3") DispatchQueue.main.sync { print("4") DispatchQueue.global(qos: .background).async { print("5") } print("6") } print("7") } print("8") } print("9") }

 Создайте свою сериюную очередь и замените в примере ей DispatchQueue.main, создайте свою конкурентную очередь и заменить ей DispatchQueue.global(qos: .background). Какой будет результат? Всегда ли будет одинаковым И почему?
 
 Какой по номеру надо поменять sync/sync чтобы не возникало дедлока в обоих случаях
 Как можно сделать в примере, чтобы очередь превратилась из конкурентной в серийную, подправте пример не исправляя создания самой очереди

 Критерии оценки:
 Оценка по пунктам:
 Сдача ДЗ - 10 баллов

 1 - 20 баллов
 2 - 20 баллов
 3 - 40 баллов
 4 - 10 баллов
 
 */

// MARK: - ЗАДАНИЕ 1
// Исследуйте код ниже и напишите, какие цифры должны вывестись в консоль, обьясните своими словами, почему именно такая последовательность по шагам.

func testQueue() {
    print("1") // 1. Выполняется синхронно на текущем потоке на main thread
    DispatchQueue.main.async { // Асинхронно добавляет блок кода в очередь main; выполнение текущего потока продолжается. Блок выполняется позже, когда main queue освободится
        print("2") // 2. Выполняется в очереди main. Становится в очередь. Выполнение блока из DispatchQueue.main.async начинается когда main queue освобождается и тогде начинает выполняться этот блок
        DispatchQueue.global(qos: .background).sync { // Синхронная. Переключается на глобальную фоновую очередь. Выполнение переходит на background queue. Блокирует текущий поток (main) до завершения блока.
            print("3")
            DispatchQueue.main.sync { // Синхронно переключается обратно на main queue. Блокирует background thread до завершения блока. Main queue занята выполнением нашего блока print("2"), но мы пытаемся синхронно выполнить еще один блок на main queue. Это создает ДЕДЛОК (deadlock), если мы уже на main thread. Однако, если мы на background thread (что и происходит), то дедлока не будет, так как main queue может обработать этот sync вызов
                print("4")
                DispatchQueue.global(qos: .background).async { // Асинхронно добавляет блок в background queue. Не блокирует выполнение. Блок будет выполнен позже.
                    print("5") // В последнюю очередь. Когда background queue освобождается, выполняется асинхронный блок
                }
                print("6") // Выполняется сразу после print("4")
            }
            print("7") // Блок завершается, background thread разблокируется
        }
        print("8") //Блок завершается, main thread разблокируется
    }
    print("9") // Выполняется сразу после print("1"), так как находится вне async и async не блокирует его
}

//print(testQueue())

/*
ОТВЕТ: 1, 9, 2, 3
 
Подсмотрел еще такое решение:
1, 9, 2, 3 или 1, 9, 2, 3, 4, 6, 7, 8, 5, если функция testQueue() не вызывается из main thread, то есть не возникает дедлок на print("4"), так как main queue будет занята выполнением блока print("4"), и sync вызов не сможет выполниться. Но если мы уже переключились на background thread (DispatchQueue.global(qos: .background).sync { ... }), то дедлока не будет.
 */

// MARK: - ЗАДАНИЕ 2
// Создайте свою серийную очередь и замените в примере ей DispatchQueue.main, создайте свою конкурентную очередь и заменить ей DispatchQueue.global(qos: .background). Какой будет результат? Всегда ли будет одинаковым И почему?

// Создание серийной очереди
let serialQueue = DispatchQueue(label: "serial", qos: .userInitiated)

// Создание конкурентной очереди
let concurrentQueue = DispatchQueue(label: "concurrent", qos: .background, attributes: .concurrent)

func testCustomQueue() {
    print("1")
    serialQueue.async {
        print("2")
        concurrentQueue.sync {
            print("3")
            serialQueue.sync {
                print("4")
                concurrentQueue.async {
                    print("5")
                }
                print("6")
            }
            print("7")
        }
        print("8")
    }
    print("9")
}

//print(testCustomQueue())

/*
 
 Последовательность вывода: 1, 9, 2, 3 (затем дедлок)
 
 ОБЪЯСНЕНИЕ ПО ШАГАМ:
 
 1. print("1") - выполняется синхронно на текущем потоке (main thread)
 2. serialQueue.async { ... } - асинхронно добавляет блок в серийную очередь serialQueue. 
    Выполнение текущего потока НЕ блокируется, продолжается дальше.
 3. print("9") - выполняется сразу после print("1"), потому что async не блокирует выполнение.
    Это происходит до того, как начнет выполняться блок serialQueue.async.
 4. Блок serialQueue.async начинает выполняться (когда serialQueue освобождается):
    - print("2") - выполняется на serialQueue
 5. concurrentQueue.sync { ... } - синхронно переключается на конкурентную очередь concurrentQueue.
    Блокирует текущий поток (serialQueue) до завершения блока.
    - print("3") - выполняется на concurrentQueue
 6. serialQueue.sync { ... } - синхронно пытается вернуться на serialQueue.
    Возникае дедлок, потому что:
    - Мы находимся внутри блока serialQueue.async (строка 75)
    - serialQueue занята выполнением этого блока
    - serialQueue.sync ждет, пока serialQueue освободится
    - Но serialQueue не может освободиться, пока не завершится блок serialQueue.async
    - Блок serialQueue.async не может завершиться, пока не завершится concurrentQueue.sync
    - concurrentQueue.sync не может завершиться, пока не завершится serialQueue.sync
    - Результат: бесконечное ожидание (deadlock)
 
 ДОПОЛНЕНИЕ: ВСЕГДА ЛИ РЕЗУЛЬТАТ БУДЕТ ОДИНАКОВЫМ?
 
 9 не всегда будет второй.
 В testCustomQueue():
 - print("1") выполняется синхронно
 - serialQueue.async { ... } добавляет блок асинхронно и не блокирует
 print("9") выполняется сразу после
- Но порядок между print("9") и print("2") не гарантирован, потому что:
 serialQueue.async ставит задачу в очередь и не ждет её выполнения
 - Если serialQueue свободна, блок может начать выполняться почти сразу, и возможна последовательность: 1, 2, 9
 - Если serialQueue занята или система перегружена, возможна последовательность: 1, 9, 2
 Итог: 1 всегда первый, а порядок между 2 и 9 не гарантирован. В исходном примере с DispatchQueue.main порядок тоже не гарантирован, но на практике main часто занят, поэтому обычно получается 1, 9, 2. С кастомной serialQueue это менее предсказуемо.
 То есть последовательность может быть либо 1, 9, 2, 3 (затем дедлок), либо 1, 2, 3 (затем дедлок, 9 может появиться в любой момент после 1).
 
 Также в случае с custom очередями:
 - Дедлок ВСЕГДА будет, независимо от того, откуда вызывается функция
 - Потому что мы всегда находимся внутри serialQueue.async, когда вызываем serialQueue.sync
 
 */

// MARK: - ЗАДАНИЕ 3
// Предотвращение дедлока

func testQueueWithoutDeadlock() {
    print("1")
    DispatchQueue.main.async {
        print("2")
        DispatchQueue.global(qos: .background).sync {
            print("3")
            //  Ниже меняем sync на async, чтобы избежать дедлока
            DispatchQueue.main.async {  // Было DispatchQueue.main.sync
                print("4")
                DispatchQueue.global(qos: .background).async {
                    print("5")
                }
                print("6")
            }
            print("7")
        }
        print("8")
    }
    print("9")
}

//print(testQueueWithoutDeadlock())

/*
 Нужно поменять 4 по счету sync (DispatchQueue.main.sync) на async (DispatchQueue.main.sync { print("4") ... })
 
 Дедлок возникает когда:
 1. Мы находимся на main thread (внутри блока DispatchQueue.main.async)
 2. Вызываем DispatchQueue.main.sync синхронно
 3. Main queue занята выполнением текущего блока
 4. Sync вызов ждет освобождения main queue
 5. Но main queue не может освободиться, пока не завершится текущий блок
 6. Текущий блок не может завершиться, пока не выполнится sync вызов
 7. Результат: бесконечное ожидание (deadlock)
 
 Заменяем DispatchQueue.main.sync на DispatchQueue.main.async
 
 Почему это решает проблему:
 - async не блокирует текущий поток
 - Блок будет выполнен позже, когда main queue освободится
 - Текущий блок может завершиться
 - Дедлока не возникает
 
Новый порядок: 1, 9, 2, 3, 7, 8, 4, 6, 5
 
 1. print("1") - синхронно
 2. print("9") - синхронно (async не блокирует)
 3. print("2") - когда main queue освобождается
 4. print("3") - синхронно на background queue
 5. DispatchQueue.main.async - асинхронно, не блокирует
 6. print("7") - выполняется сразу (async не блокировал)
 7. print("8") - выполняется после завершения sync блока
 8. print("4") - когда main queue освобождается
 9. print("6") - сразу после print("4")
 10. print("5") - когда background queue освобождается
  */

// MARK: - ЗАДАНИЕ 4
// Как сделать очередь из конкурентной в серийную, не исправляя создания?

// Решение: Существует 2 основных способа: Использовать флаг .barrier при вызове async/sync методов или использовать setTarget(queue:) для установки серийной очереди как target.

func testQueueConcurrentToSerial() {
    print("1")
    DispatchQueue.main.async {
        print("2")
        // Используем barrier для превращения конкурентной очереди в серийную для этого блока
        let concurrentQueue = DispatchQueue.global(qos: .background)
        
        // Используем barrier flag для синхронного выполнения
        // Это заставит все предыдущие задачи завершиться перед выполнением этого блока
        concurrentQueue.sync(flags: .barrier) {
            print("3")
            DispatchQueue.main.sync {
                print("4")
                concurrentQueue.async(flags: .barrier) {
                    print("5")
                }
                print("6")
            }
            print("7")
        }
        print("8")
    }
    print("9")
}

func testQueueWithSetTarget() {
    // 1. Создаем серийную очередь для замены DispatchQueue.main
    let serialQueue = DispatchQueue(label: "com.recipecook.serial", qos: .userInitiated)
    
    // 2. Создаем конкурентную очередь с .initiallyInactive
    let concurrentQueueNew = DispatchQueue(
        label: "example.concurrent",
        attributes: [.concurrent, .initiallyInactive]  // Важно!
    )
    
    // 3. Создаем серийную очередь как target
    let serialTargetQueue = DispatchQueue(label: "example.serial.target")
    
    // 4. Устанавливаем target ДО активации
    concurrentQueueNew.setTarget(queue: serialTargetQueue)
    
    // 5. Активируем очередь после назначения target
    concurrentQueueNew.activate()
    
    // Теперь используем эти очереди в исходном примере
    print("1")
    serialQueue.async {  // Заменяем DispatchQueue.main
        print("2")
        concurrentQueueNew.sync {  // Заменяем DispatchQueue.global
            print("3")
            serialQueue.sync {
                print("4")
                concurrentQueueNew.async {
                    print("5")
                }
                print("6")
            }
            print("7")
        }
        print("8")
    }
    print("9")
}

