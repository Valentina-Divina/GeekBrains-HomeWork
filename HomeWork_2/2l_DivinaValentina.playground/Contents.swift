import UIKit


/*
 ======================================================================
 ЗАДАНИЕ 1. Написать функцию, которая определяет, четное число или нет.
 ======================================================================
 */

func evenNumber(number: Int) -> Bool {
    let a = number
    if (a % 2 ) == 0 {
        print("\(number) четное число")
        return true
    } else {
        print("\(number) не четное число")
        return false
    }
}

evenNumber(number: 5)

/*
 ==================================================================================
 ЗАДАНИЕ 2. Написать функцию, которая определяет, делится ли число без остатка на 3.
 ==================================================================================
 */

func divisionByThree(number: Int) -> Bool {
    let a = number
    if (a % 3) == 0 {
        print("\(number) делится  без остатка на 3")
        return true
    } else {
        print("\(number) не четное число")
        return false
    }
}

divisionByThree(number: 9)

/*
 Решила собрать две прошлые функции в одну, т.к. код в них идентичен.
 */

func evenAndOddNumber(number: Int) {
    switch number {
    case let k where k%2==0:
        print("Делится без остатка на 2")
    case let k where k%3==0:
        print("Делится без остатка на 3")
    default:
        print("Не делится без остатка ни на 2, ни на 3")
    }
}

evenAndOddNumber(number: 5)

/*
 ====================================================
 ЗАДАНИЕ 3: Создать возрастающий массив из 100 чисел.
 ====================================================
 */

var array = Array(0...100) // 1 способ

var arrayIsEmpty: [Int] = []  // 2 способ с циклом while

while (arrayIsEmpty.count < 100) {
    arrayIsEmpty.append(arrayIsEmpty.count + 1)
}

/*  ИЛИ 3 способ с for
 
 for i in 1...100 {
 arrayIsEmpty.append(i)
 print(i)
 
 }
 arrayIsEmpty.count
 */

print(arrayIsEmpty)

/*
 ==========================================================================================
 ЗАДАНИЕ 4: Удалить из этого массива все четные числа и все числа, которые не делятся на 3.
 ==========================================================================================
 */



// 1. Через фильтрацию
func arrayFilter(array: [Int]) -> [Int] {
    
    var arrayForFilter = array
    
    arrayForFilter = arrayForFilter.filter{$0 % 2 != 0 && $0 % 3 == 0 }
    
    return arrayForFilter
}

let filtered = arrayFilter(array: arrayIsEmpty)
print(filtered)

// 2. Через удаление
func removeArray(array: [Int]) -> [Int] {
    var newArray = array
    newArray.removeAll(where: {$0 % 2 == 0 || $0 % 3 != 0})
    return newArray
}

removeArray(array: arrayIsEmpty)
print(removeArray(array: arrayIsEmpty))


/*
 ====================================================================================================
 ЗАДАНИЕ 5:Написать функцию, которая добавляет в массив новое число Фибоначчи, и добавить при помощи
 нее 50 элементов.
 ====================================================================================================
 */

var fibonacciArray: [Int] = []

func addFibonacciNumber(array: inout [Int], count: Int) {
    if(array.isEmpty) {
        array.append(0)
        array.append(1)
    }
    
    if count <= 0 {
        print("Exception: Undefined count.")
        return
    }
    
    for _ in 1...count {
        let lastIndex = array.count-1
        let prelastIndex = array.count-2
        array.append((array[lastIndex]) + (array[prelastIndex]))
    }
}

addFibonacciNumber(array: &fibonacciArray, count: 50)
print(fibonacciArray)

/*
 =================================================================================================
 ЗАДАНИЕ 6: Заполнить массив из 100 элементов различными простыми числами. Натуральное число,
 большее единицы, называется простым, если оно делится только на себя и на единицу. Для нахождения
 всех простых чисел не больше заданного числа n, следуя методу Эратосфена
 =================================================================================================
 */

func allPrimeNumbersTo(maxNumber: Int) {
    
    var primeNumber = 2
    
    var data = Array(2...maxNumber)
    
    while (primeNumber * primeNumber <= maxNumber) {
        data.removeAll(where: { number in
            number >= primeNumber * primeNumber && number % primeNumber == 0
        })
        primeNumber = data.first(where: {$0 > primeNumber})!
    }
    
    print("Все простые числа до \(maxNumber)")
    print(data)
}

allPrimeNumbersTo(maxNumber: 100)












