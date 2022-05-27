import UIKit
import Foundation
import Darwin.C.math

// ЗАДАНИЕ 1: Решить квадратное уравнение.

// Высчитываем первый корень
func firstSqrt(b: Double, D: Double, a: Double) -> Double {
    return ((b * -1)+sqrt(D)) / (2*a)
}

// Высчитываем второй корень
func secondSqrt(b: Double, D: Double, a: Double) -> Double {
    return  ((b * -1)-sqrt(D)) / (2*a)
}

// Высчитываем дискриминант и решаем уравнение исходя из результата
func SolvingAQuadraticEquationant(a: Double, b: Double, c: Double) -> (x1:Double?, x2: Double?) {
    let D = b*b-4*a*c
    var x1: Double? = nil
    var x2: Double? = nil
    if D < 0 {
        print("Дискриминант: \(D). Корней нет.")
    } else if (D == 0) {
        x1 = firstSqrt(b: b, D: D, a: a)
        print("Дискриминант: \(D). Один корень: \(x1)")
    } else if (D > 0) {
        x1 = firstSqrt(b: b, D: D, a: a)
        x2 = secondSqrt(b: b, D: D, a: a)
        print("Дискриминант: \(D). Первый корень: \(x1), второй корень: \(x2)")
    }
    
    return (x1,x2)
}


// ЗАДАНИЕ 2: Даны катеты прямоугольного треугольника. Найти площадь, периметр и гипотенузу треугольника.

// Гипотенуза
func hypotenuseOfARightTriangle(leg1: Double, leg2: Double) -> Double {
    return sqrt((leg1 * leg1) + (leg2 * leg2))
}

// Периметр
func perimeterOfARightTriangle(leg1: Double, leg2: Double, hypotenuse: Double) -> Double {
    return leg1 + leg2 + hypotenuse
}

// Площадь
func areaOfARightTriangle(leg1:Double, leg2: Double) -> Double {
    return (leg1 * leg2) / 2
    
}

// Высчитываем гипотенузу, площадь и периметр по двум катетам
func calculateParameters(leg1: Double, leg2: Double) {
    let hypotenuse = hypotenuseOfARightTriangle(leg1: leg1, leg2: leg2)
    let perimeter = perimeterOfARightTriangle(leg1: leg1, leg2: leg2, hypotenuse: hypotenuse)
    let area = areaOfARightTriangle(leg1: leg1, leg2: leg2)
    
    print("Гипотенуза: \(hypotenuse)\nПериметр: \(perimeter)\nПлощадь: \(area)")
    
}

// ЗАДАНИЕ 3: * Пользователь вводит сумму вклада в банк и годовой процент. Найти сумму вклада через 5 лет.

// Рассчитываем простой процент вклада через 5 лет
func depositAmountFor5Years(depositAmount: Double, annualPercentage: Double) {
    print("Начальный вклад \(depositAmount)")
    let normalizedPercent = annualPercentage / 100
    let result = (depositAmount * normalizedPercent * 5) + depositAmount
    print("Вклад через 5 лет \(result)")
}


// Конечный результат ДЗ:

// 1 задание:
SolvingAQuadraticEquationant(a: 3, b: 4, c: -7)
// 2 задание:
calculateParameters(leg1: 4 , leg2: 5)
// 3 задание:
depositAmountFor5Years(depositAmount: 50000, annualPercentage: 10)


