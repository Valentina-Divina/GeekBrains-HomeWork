import UIKit

/*
 =======================================================================================================
 1. Описать класс Car c общими свойствами автомобилей и пустым методом действия по аналогии с прошлым заданием.
 
 2. Описать пару его наследников trunkCar и sportСar. Подумать, какими отличительными свойствами обладают эти автомобили. Описать в каждом наследнике специфичные для него свойства.
 
 3. Взять из прошлого урока enum с действиями над автомобилем. Подумать, какие особенные действия имеет trunkCar, а какие – sportCar. Добавить эти действия в перечисление.
 
 4. В каждом подклассе переопределить метод действия с автомобилем в соответствии с его классом.
 
 5. Создать несколько объектов каждого класса. Применить к ним различные действия.
 
 6. Вывести значения свойств экземпляров в консоль.
 =======================================================================================================
 
 */

class Car {
    var mark: String
    var year: Int
    var isEngineStarted: Bool
    var maxBagaznikSize: UInt
    var currentBagaznikSize: UInt
    var windowIsOpen: Bool
    
    
    init(mark: String, year: Int, isEngineStarted: Bool, maxBagaznikSize: UInt, currentBagaznikSize: UInt, windowIsOpen: Bool) {
        self.mark = mark
        self.year = year
        self.isEngineStarted = isEngineStarted
        self.maxBagaznikSize = maxBagaznikSize
        self.currentBagaznikSize = currentBagaznikSize
        self.windowIsOpen = windowIsOpen
    }
    
    enum Action {
        case Start, Stop
        case FillBagaznik(volume: UInt), RemoveFromBagaznik(volume: UInt)
        case Open, Close
        case HitchATrailer, UnhookTheTrailer
        case BrakesAreWork
        case NOSOff, NOSOnn
        case DriftStart(side: TurnSide), DriftStop
    }
    enum TurnSide {
        case Left, Right
    }
    
    func handleAction(action: Action) {
        switch action {
        case .Start:
            if(isEngineStarted) {
                print("Машина уже заведена")
            } else {
                self.isEngineStarted = true
                print("Стартуем!")
            }
        case .Stop:
            if(!isEngineStarted) {
                print("Машина уже выключена")
            } else {
                self.isEngineStarted = false
                print("Приехали")
            }
            
        case .FillBagaznik(let volume):
            if (self.currentBagaznikSize + volume) > maxBagaznikSize {
                print("Не хватает места в багажнике. Загруженность: \(currentBagaznikSize)/\(maxBagaznikSize) ")
            } else {
                self.currentBagaznikSize += volume
                print("Текущая заполненность \(currentBagaznikSize)/\(maxBagaznikSize)")
            }
            
        case .RemoveFromBagaznik(let volume):
            
            if Int(self.currentBagaznikSize)  - Int(volume) <= 0 {
                self.currentBagaznikSize = 0
                print("Багажник пуст. Загруженность: \(currentBagaznikSize)/\(maxBagaznikSize) ")
                return
            } else {
                self.currentBagaznikSize -= volume
                print("Текущая заполненность \(currentBagaznikSize)/\(maxBagaznikSize)")
                
            }
            
        case .Open:
            if(windowIsOpen) {
                print("Окна уже открыты")
            }
            self.windowIsOpen = true
            print("Окна открыты")
            
        case .Close:
            if(!windowIsOpen) {
                print("Окна уже закрыты")
            }
            self.windowIsOpen = false
            print("Окна закрыты")
            
        default:
            print("не понял")
        }
    }
}

class TrunkCar: Car {
    var trailer: Bool // новые свойства
    var brakes: Bool
    // Перечисляем все свойства
    init(mark: String, year: Int, isEngineStarted: Bool, maxBagaznikSize: UInt, currentBagaznikSize: UInt, windowIsOpen: Bool, trailer: Bool, brakes: Bool) {  2
        self.trailer = trailer // инициализируем новые свойства
        self.brakes = brakes
        //  используем конструктор из родителя, чтобы завершить инициализацию класса
        super.init(mark: mark, year: year, isEngineStarted: isEngineStarted, maxBagaznikSize: maxBagaznikSize, currentBagaznikSize: currentBagaznikSize, windowIsOpen: windowIsOpen)
    }
    
    override func handleAction(action: Action) {
        switch action {
        case .HitchATrailer:
            if(trailer) {
                print("Прицеп уже закреплен")
            } else {
                self.trailer = true
                print("Прицеп закреплен")
            }
        case.UnhookTheTrailer:
            if(!trailer) { print("Прицеп уже отстегнут")
            } else { self.trailer = true
                print("Прицеп остегнут")
            }
        case.BrakesAreWork:
            if(brakes) == true {
                print("Тормоза работают")
                
            } else {
                print("Тормоза не работают!")
            }
        default: super.handleAction(action: action)
        }
    }
}

class SportCar: Car {
    var nitrousOxideSystem: Bool
    var drift: Bool
    
    init(mark: String, year: Int, isEngineStarted: Bool, maxBagaznikSize: UInt, currentBagaznikSize: UInt, windowIsOpen: Bool, nitrousOxideSystem: Bool, drift: Bool ) {
        self.nitrousOxideSystem = nitrousOxideSystem
        self.drift = drift
        super.init(mark: mark, year: year, isEngineStarted: isEngineStarted, maxBagaznikSize: maxBagaznikSize, currentBagaznikSize: currentBagaznikSize, windowIsOpen: windowIsOpen)
    }
    
    override func handleAction(action: Car.Action) {
        switch action {
        case .NOSOnn:
            if(nitrousOxideSystem) {
                print("Система закиси азота уже включена")
            } else {
                self.nitrousOxideSystem = true
                print("Система закиси азота включена")
            }
        case.NOSOff:
            if(!nitrousOxideSystem) { print("Система закиси азота уже отключена")
            } else { self.nitrousOxideSystem = false
                print("Система закиси азота отключена")
            }
            
        case.DriftStart(let side):
            drift = true
            let sideStr = side == TurnSide.Left ? "ВЛЕВО!" : "ВПРАВО!"
            print("НАЧАЛИ ДРИФТИТЬ ВРВРВРВРВРВРВ \(sideStr)")
            
        case.DriftStop:
            drift = false
            print("Перестали дрифтить.")
            
        default: super.handleAction(action: action)
        }
    }
}

var truck = TrunkCar.init(mark: "gazel", year: 123, isEngineStarted: false, maxBagaznikSize: 900, currentBagaznikSize: 300, windowIsOpen: true, trailer: true, brakes: false)

var sportCar = SportCar.init(mark: "sportivnaya_mashina", year: 123, isEngineStarted: true, maxBagaznikSize: 900, currentBagaznikSize: 300, windowIsOpen: true, nitrousOxideSystem: true, drift: false)

truck.handleAction(action: Car.Action.HitchATrailer)
truck.handleAction(action: Car.Action.Start)
truck.handleAction(action: Car.Action.BrakesAreWork)

print("~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~")

sportCar.handleAction(action: Car.Action.DriftStart(side: Car.TurnSide.Left))
sportCar.handleAction(action: Car.Action.DriftStart(side: Car.TurnSide.Right))
sportCar.handleAction(action: Car.Action.DriftStop)

print("▓▒░(°◡°)░▒▓")
