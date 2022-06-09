import UIKit

/*
 ========================================================================================================
 1. Реализовать свой тип коллекции «очередь» (queue) c использованием дженериков.
 2. Добавить ему несколько методов высшего порядка, полезных для этой коллекции (пример: filter для массивов)
 3. * Добавить свой subscript, который будет возвращать nil в случае обращения к несуществующему индексу.
 ========================================================================================================
 */


struct QueueUniversal<Element> { //Очередь на основе дженериков
    private var elements = [Element]()
    
    mutating func push(_ element: Element) { // функция добавления эелемента в очередь
        elements.append(element)
    }
    
    mutating func pop() ->  Element { // функция удаления первого элемента из очереди
        return elements.removeFirst()
    }
    
    mutating  func foundIndex<T: Equatable>(valueToFound: T) -> Int? {
        for (index, value) in elements.enumerated() {
            if value as! T == valueToFound {
                print("Элемент \(valueToFound) находится по индексу \(index)")
                return index
            }
        }
        return nil
    }
    
    
    func transform<TransformResultType>(transformation: (Element) -> TransformResultType) -> [TransformResultType] {
        return elements.map {
            transformation($0)
        }
    }
    
    func filter(filterClojure: (Element) -> Bool) -> [Element] {
        var newFilterArray = [Element]()
        
        for i in elements {
            let clojureResult = filterClojure(i)
            print("i: \(i) filterClojure: \(clojureResult)")
            if (clojureResult) {
                newFilterArray.append(i)
            }
        }
        
        return newFilterArray
    }
    
    subscript (index: Int ) -> Element? {
        guard (index >= 0) && (index < elements.count) else // guard *его условие* else -> true
        { return nil } // если условие guard не выполняеться -> условие guard == false
        
        return elements[index]
    }
}

var queue = QueueUniversal<Int>()
queue.push(1)
queue.push(3)
queue.push(4)
queue.push(5)
queue.push(6)
print(queue.pop())
print(queue.pop())
print(queue.pop())
print(queue.pop())
queue.push(1)
queue.push(3)
queue.push(4)
queue.push(5)
queue.push(6)

print(queue.foundIndex(valueToFound: 5) ?? -1)

let transformResult1 = queue.transform(transformation: {
    "Kek: " + String($0)
})

let doubleResult = queue.transform(transformation: { element in
    Double(element)/2.0
})

let filterResult = queue.filter(filterClojure: { elementForClojure in
    elementForClojure % 2 == 0
})

print(transformResult1)
print(doubleResult)
print(filterResult)


