//
//  Snake.swift
//  Snake_less_8
//
//  Created by Valya on 14.06.2022.
//

import UIKit
import SpriteKit


class Snake: SKShapeNode {
    
    var body = [SnakeBodyPart]() // здесь тело змеи
    
    let moveSpeed: CGFloat = 125.0 // скорость змейки
    var angle: CGFloat = 0.0 // угол поворота
    
    init(atPoint point: CGPoint) {
        
        super.init()
        let head = SnakeHead(atPoint: point) // экземляр класса SnakeHead
        body.append(head)
        addChild(head)
        
    }
    
    func addBodyPart() {
        let newBodyPart = SnakeBodyPart(atPoint: CGPoint(x: body[0].position.x, y: body[0].position.y))
        body.append(newBodyPart)
        addChild(newBodyPart)
    }
    
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}

//перемещение змеи
extension Snake {
    
    func move() {
        guard !body.isEmpty else {return} // проверка тела змеи на пустоту
        
        let head = body[0]
        moveHead(head)
        
        for index in (0..<body.count) where index > 0 {
            let previousBodyPart = body[index-1]
            let currentBodyPart = body[index]
            
            moveBodyPart(previousBodyPart, c: currentBodyPart)
        }
        
    }
    
    func moveHead(_ head: SnakeBodyPart) { // перемещение головы на новую позицию
        
        let dx = moveSpeed * sin(angle)
        let dy = moveSpeed * cos(angle)
        
        let nextPosition = CGPoint(x: head.position.x + dx,
                                   y: head.position.y + dy)
        
        let moveAction = SKAction.move(to: nextPosition, duration: 1.0) // перемещение
        head.run(moveAction)
        
    }
    
    // р - 1-й элемент, с - элемент, который перемещаем
    func moveBodyPart(_ p: SnakeBodyPart, c: SnakeBodyPart) {
        let moveAction = SKAction.move(to: CGPoint(x: p.position.x,
                                                   y: p.position.y),
                                       duration: 0.1)
        
        
        c.run(moveAction)
    }
    
}


//поворот змеи
extension Snake {
    
    func moveClockwise() {
        angle += CGFloat(Double.pi/2)
    }
    
    func moveCounterClockwise() {
        angle -= CGFloat(Double.pi/2)
    }
    
}

