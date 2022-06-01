//
//  3l_DivinaValentrina.swift
//
//
//  Created by Valya on 30.05.2022.
//

import Foundation

/*
 
 =============================================================================================================
 1. Описать несколько структур – любой легковой автомобиль SportCar и любой грузовик TrunkCar. +
 
 2. Структуры должны содержать марку авто, год выпуска, объем багажника/кузова, запущен ли двигатель, открыты ли окна, заполненный объем багажника.
 
 3. Описать перечисление с возможными действиями с автомобилем: запустить/заглушить двигатель, открыть/закрыть окна, погрузить/выгрузить из кузова/багажника груз определенного объема.
 
 4. Добавить в структуры метод с одним аргументом типа перечисления, который будет менять свойства структуры в зависимости от действия.
 
 5. Инициализировать несколько экземпляров структур. Применить к ним различные действия.
 
 6. Вывести значения свойств экземпляров в консоль.
 ==========================================================================================================
 
 */

protocol Transport {
    var mark: String { get set }
    var year: Int { get set }
    var isEngineStarted: Bool { get set }
    var maxBagaznikSize: UInt { get set }
    var currentBagaznikSize: UInt { get set }
    var windowIsOpen: Bool {get set}
    mutating func handleAction(action: Action)
}

enum Action {
    case Start, Stop
    case FillBagaznik(volume: UInt), RemoveFromBagaznik(volume: UInt)
    case Open, Close
}


struct SportCar: Transport {
    var mark: String
    var year: Int
    var isEngineStarted: Bool = false
    var windowIsOpen: Bool = false
    var maxBagaznikSize: UInt = 500
    var currentBagaznikSize: UInt = 0
    
    mutating func handleAction(action: Action) {
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
            
        case  .Open:
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
        }
    }
    
}

struct TruckCar: Transport {
    var mark: String
    var year: Int
    var isEngineStarted: Bool = false
    var maxBagaznikSize: UInt = 10000
    var currentBagaznikSize: UInt = 0
    var windowIsOpen: Bool = false
    
    mutating func handleAction(action: Action) {
        switch action {
        case .Start:
            if(isEngineStarted) {
                print("Грузовик уже заведен")
            } else {
                self.isEngineStarted = true
                print("Стартуем!")
            }
        case .Stop:
            if(!isEngineStarted) {
                print("Грузовик уже выключен")
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
            
        case  .Open:
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
        }
    }
    
    
}

var sportCar = SportCar(mark: "Volvo", year: 2019, windowIsOpen: false, maxBagaznikSize: 900, currentBagaznikSize: 50) //  иницаиализация экземляра
sportCar.handleAction(action: Action.FillBagaznik(volume: 321))
sportCar.handleAction(action: Action.Open)
sportCar.handleAction(action: Action.Start)

print("==========================================================")

var truckCar = TruckCar(mark: "Газель", year: 1956, isEngineStarted: true, maxBagaznikSize: 1100, currentBagaznikSize: 1099, windowIsOpen: true)

truckCar.handleAction(action: Action.Close)
truckCar.handleAction(action: Action.FillBagaznik(volume: 2))
truckCar.handleAction(action: Action.Stop)


