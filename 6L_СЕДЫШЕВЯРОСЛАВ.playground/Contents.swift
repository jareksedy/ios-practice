// Урок 6. Практическое задание.
// Ярослав Седышев <jareksedy@icloud.com>

// 1. Реализовать свой тип коллекции «очередь» (queue) c использованием дженериков.

struct Queue<T>: CustomStringConvertible {
    
    // Массив элементов
    
    private var items: [T] = []
    
    // Начало очереди (первый элемент)
    
    var head: T? {items.first}
    
    // Конец очереди (последний элемент)
    
    var tail: T? {items.last}
    
    // Добавить элемент в очередь
    
    mutating func enqueue(_ item: T) {
        items.append(item)
    }
    
    // Удалить элемент из очереди
    
    mutating func dequeue() -> T? {
        if !items.isEmpty {
            return items.removeFirst()
        } else {
            return nil
        }
    }
    
    // Проверить не является ли очередь пустой
    
    func isEmpty () -> Bool {
        return items.isEmpty
    }
    
    // Дескрипшн
    
    var description: String {
        
        var s: String = ""
        
        if self.isEmpty() {return "Queue empty."}
        
        for (index, element) in items.enumerated() {
            
            s += "[\(index)] = \(element)"
            
            switch index {
            case 0: s += " ← (head)\n"
            case items.count - 1: s += " ← (tail)\n"
            default: s += "\n"
            }

        }
        
        return s
        
    }
    
}

// 2. Добавить ему несколько методов высшего порядка, полезных для этой коллекции (пример: filter для массивов)

extension Queue {
        
    // Возвращает новую очередь из элементов, совпадающих с условием фильтра
    
    func filter(_ by: (T) -> Bool) -> Queue<T> {
        
        var newQueue = Queue<T>()
        
        for element in self.items {
            if by(element) {newQueue.enqueue(element)}
        }
        
        return newQueue
    
    }
    
    // Возвращает новую очередь из элементов над каждым из которых применена переданная функция
    
    func map(_ transform: (T) -> T) -> Queue<T> {
        
        var newQueue = Queue<T>()
        
        for element in self.items {
            newQueue.enqueue(transform(element))
        }
        
        return newQueue
    
    }
}

// 3. * Добавить свой subscript, который будет возвращать nil в случае обращения к несуществующему индексу.

extension Queue {
    
    subscript(index: Int) -> T? {
        return index < items.count ? items[index] : nil
    }

}

// Посмотрим результат

var myStringQueue = Queue<String>()
var myOtherStringQueue = Queue<String>()
var myOtherStringQueueMapped = Queue<String>()

var myIntQueue = Queue<Int>()
var myOtherIntQueue = Queue<Int>()
var myOtherIntQueueMapped = Queue<Int>()

// Добавим элементы в очередь

myStringQueue.enqueue("John")
myStringQueue.enqueue("Paul")
myStringQueue.enqueue("Ringo")
myStringQueue.enqueue("George")

myIntQueue.enqueue(29)
myIntQueue.enqueue(30)
myIntQueue.enqueue(44)
myIntQueue.enqueue(81)

// Выведем дескрипшны

print(myStringQueue)
print(myIntQueue)

// Уберем из очереди элемент

if let s = myStringQueue.dequeue() {print(s)}
if let i = myIntQueue.dequeue() {print(i)}

print("")

// Выведем дескрипшны

print(myStringQueue)
print(myIntQueue)

// Протестим методы filter и map и выведем дескрипшны

myOtherStringQueue = myStringQueue.filter{$0.count < 6}
print(myOtherStringQueue)

myOtherStringQueueMapped = myOtherStringQueue.map{$0.uppercased()}
print(myOtherStringQueueMapped)

myOtherIntQueue = myIntQueue.filter{$0 % 2 == 0}
print(myOtherIntQueue)

myOtherIntQueueMapped = myOtherIntQueue.map{$0 * $0}
print(myOtherIntQueueMapped)

// Протестим сабскрипт

if let ss = myOtherStringQueueMapped[1] {print(ss)} else {print("Несуществующий индекс.")}
if let ii = myOtherIntQueueMapped[99] {print(ii)} else {print("Несуществующий индекс.")}
