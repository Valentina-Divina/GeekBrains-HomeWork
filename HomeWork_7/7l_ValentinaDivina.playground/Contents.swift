import UIKit

/*
 ============================================================================================================
 1. Придумать класс, методы которого могут завершаться неудачей и возвращать либо значение, либо ошибку Error?. Реализовать их вызов и обработать результат метода при помощи конструкции if let, или guard let.
 ============================================================================================================
 */

class Randomize {
    
    func randomizeValues(value: Int) -> (Bool?, RandimzeFuncError?) {
        
        if value > 10 {
            return (nil, RandimzeFuncError.numberGreaterThan10)
        }
        
        if value <= 0 {
            return (nil, RandimzeFuncError.numberLessThanZero)
        }
        
        let conceivedNumber = Int.random(in: 1...10)
        if value != conceivedNumber {
            print("Ваше число и загаданное значение не совпадают")
            return (false, nil)
        } else {
            print("Вы угадали")
        }
        return (true, nil)
    }
}

// error

enum RandimzeFuncError: Error {
    case numberGreaterThan10
    case numberLessThanZero
}

var randomizator = Randomize()
let result = randomizator.randomizeValues(value: 11)


if let resultOk = result.0 {
    print("Результат угадывания \(resultOk)")
} else if let error = result.1 {
    print("Oшибка \(error)")
}

/*
 ============================================================================================================
 2. Придумать класс, методы которого могут выбрасывать ошибки. Реализуйте несколько throws-функций. Вызовите их и обработайте результат вызова при помощи конструкции try/catch.
 ============================================================================================================
 */

class PassswordChecker {
    
    func passwordCheckFunc(password: String) throws -> Bool  {
        // проверка на запрещенные символы
        let notUseSymbol: [Character] = ["?","!","_","."]
        if password.contains(where: { char in
            notUseSymbol.contains(char)
        }) {
            throw PassswordCheckerError.excludedSymbol
        }
        
        // проверка на длину пароля
        if password.count <= 10 {
            throw PassswordCheckerError.shortPassword
        }
        print("Все отлично")
        return true
    }
}

enum PassswordCheckerError: Error { // перечисление с ошибками
    case shortPassword
    case excludedSymbol
}


var testpassword = PassswordChecker()
// Обработка возможных ошибок
do {
    try testpassword.passwordCheckFunc(password: "521") // метод, запускающий наш метод
} catch PassswordCheckerError.shortPassword {
    print("Пароль слишком короткий")
}

do {
    try testpassword.passwordCheckFunc(password: "3232334?")
} catch PassswordCheckerError.excludedSymbol {
    print("Пароль не должен содеражать символы: ?!_.")
}


