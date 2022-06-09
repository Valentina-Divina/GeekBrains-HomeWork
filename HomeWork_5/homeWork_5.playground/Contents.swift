import UIKit
/*
 ========================================================================================================
 1. Создать протокол «Car» и описать свойства, общие для автомобилей, а также метод действия.
 2. Создать расширения для протокола «Car» и реализовать в них методы конкретных действий с автомобилем: открыть/закрыть окно, запустить/заглушить двигатель и т.д. (по одному методу на действие, реализовывать следует только те действия, реализация которых общая для всех автомобилей).
 3. Создать два класса, имплементирующих протокол «Car» - trunkCar и sportСar. Описать в них свойства, отличающиеся для спортивного автомобиля и цистерны.
 4. Для каждого класса написать расширение, имплементирующее протокол CustomStringConvertable.
 5. Создать несколько объектов каждого класса. Применить к ним различные действия.
 6. Вывести сами объекты в консоль.
 ========================================================================================================
 */


protocol Car {
    
    var mark: String { get set }
    var year: Int { get set }
    var isEngineStarted: Bool { get set }
    var maxBootSize: UInt { get set }
    var currentBootSize: UInt { get set }
    var windowIsOpen: Bool { get set }
    
}

extension Car {
    mutating func startEngine() {
        self.isEngineStarted = true
    }
    
    mutating func stopEngine() {
        self.isEngineStarted = false
    }
    
    mutating func fillBoot(weight: UInt) {
        if (currentBootSize + weight) > maxBootSize {
            return
        }
        currentBootSize += weight
    }
    
    mutating func removeBoot(weight: UInt) {
        if (currentBootSize - weight) <= 0 {
            return
        }
        currentBootSize -= weight
    }
    
    mutating func openWindow(){
        self.windowIsOpen = true
    }
    
    mutating func closeWindow() {
        self.windowIsOpen = false
    }
}

class TrunkCar: Car {
    var mark: String
    var year: Int
    var isEngineStarted: Bool
    var maxBootSize: UInt
    var currentBootSize: UInt
    var windowIsOpen: Bool
    var trailer: Bool // новые свойства
    // Перечисляем все свойства
    init(mark: String, year: Int, isEngineStarted: Bool, maxBootSize: UInt, currentBootSize: UInt, windowIsOpen: Bool, trailer: Bool) {
        self.mark = mark
        self.year = year
        self.isEngineStarted = isEngineStarted
        self.maxBootSize = maxBootSize
        self.currentBootSize = currentBootSize
        self.windowIsOpen = windowIsOpen
        self.trailer = trailer // инициализируем новые свойства
    }
}

extension TrunkCar: CustomStringConvertible {
    var description: String {
        let engineStatus = isEngineStarted ? "заведен" : "заглушен"
        let windowStatus = windowIsOpen ? "открыты" : "закрыты"
        let trailerStatus = trailer ? "прикреплен" : "откреплен "
        return "Марка машины: \(mark)\nГод выпуска: \(year) г.\nСтатус двигателя: \(engineStatus) \nЗагруженность багажника: \(currentBootSize)|\(maxBootSize)  \nСтатус окон: \(windowStatus) \nПрицеп: \(trailerStatus)\n\n-------------------"
    }
    
    func printDescription() {
        print(description)
    }
    func hitchATrailer() {
        self.trailer = true
    }
    func unhookTheTrailer() {
        self.trailer = false
    }
}


class SportCar: Car {
    
    var mark: String
    var year: Int
    var isEngineStarted: Bool
    var maxBootSize: UInt
    var currentBootSize: UInt
    var windowIsOpen: Bool
    var nitrousOxideSystem: Bool
    var drift: TurnSide
    
    init(mark: String, year: Int, isEngineStarted: Bool, maxBootSize: UInt, currentBootSize: UInt, windowIsOpen: Bool, nitrousOxideSystem: Bool, drift: TurnSide ) {
        self.mark = mark
        self.year = year
        self.isEngineStarted = isEngineStarted
        self.maxBootSize = maxBootSize
        self.currentBootSize = currentBootSize
        self.windowIsOpen = windowIsOpen
        self.nitrousOxideSystem = nitrousOxideSystem
        self.drift = drift
    }
}

extension SportCar: CustomStringConvertible {
    var description: String {
        let engineStatus = isEngineStarted ? "заведен" : "заглушен"
        let windowStatus = windowIsOpen ? "открыты" : "закрыты"
        let nosStatus = nitrousOxideSystem ? "включена" : "выключена"
        return "Марка машины: \(mark)\nГод выпуска: \(year) г.\nСтатус двигателя: \(engineStatus) \nЗагруженность багажника: \(currentBootSize)|\(maxBootSize) \nСтатус окон: \(windowStatus) \nСистема закиси азота: \(nosStatus) \nПоворот: \(drift.rawValue)\n\n------------------"
    }
    enum Action {
        case DriftStart(side: TurnSide), DriftStop
    }
    enum TurnSide: String {
        case Left = "Влево", Right = "Вправо", None = "Прямо"
    }
    
    func printDescription() {
        print(description)
    }
    func nosONN() {
        self.nitrousOxideSystem = true
    }
    func nosOFF() {
        self.nitrousOxideSystem = false
    }
    func driftStart(side: TurnSide) {
        drift = side
    }
}

var truckCar = TrunkCar(mark: "Kamaz", year: 1976, isEngineStarted: false, maxBootSize: 2000, currentBootSize: 235, windowIsOpen: false, trailer: true)
truckCar.startEngine()
truckCar.fillBoot(weight: 1223)
truckCar.openWindow()
print(truckCar)

var sportCar = SportCar(mark: "Volvo", year: 2355, isEngineStarted: true, maxBootSize: 900, currentBootSize: 333, windowIsOpen: true, nitrousOxideSystem: true, drift: SportCar.TurnSide.None)
sportCar.closeWindow()
print(sportCar)


