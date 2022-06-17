//
//  GameScene.swift
//  Snake_less_8
//
//  Created by Valya on 13.06.2022.
//

import SpriteKit
import GameplayKit

struct CollisionCategory {
    // битовый сдвиг
    static let Snake: UInt32 = 0x1 << 0 //0001
    static let SnakeHead: UInt32 = 0x1 << 1 //0010
    static let Apple: UInt32 = 0x1 << 2 //0100
    static let EdgeBody: UInt32 = 0x1 << 3 //1000
    
}

class GameScene: SKScene {
    
    var snake: Snake? // экземпляр класса Snake
    
    override func didMove(to view: SKView) {
        
        backgroundColor = SKColor.black
        self.physicsWorld.gravity = CGVector(dx: 0, dy: 0)
        self.physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        
        self.physicsBody?.allowsRotation = false
        
        view.showsPhysics = true
        
        initButtons()
        
        createApple()
        
        // размещаем змейку в центре экрана
        snake = Snake(atPoint: CGPoint(x: view.scene!.frame.midX, y: view.scene!.frame.midY))
        self.addChild(snake!)
        
        self.physicsWorld.contactDelegate = self
        
        self.physicsBody?.categoryBitMask = CollisionCategory.EdgeBody
        self.physicsBody?.collisionBitMask = CollisionCategory.Snake | CollisionCategory.SnakeHead
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        
        // кнопка будет зеленой при нажатии
        
        for touch in touches {
            let touchLocation = touch.location(in: self) // location -  куда мы нажали
            
            guard let touchNode = self.atPoint(touchLocation) as? SKShapeNode, // сохраняем обьект под пальцем
                  touchNode.name == "counterClockwiseButton" || touchNode.name == "counterClockButton" else {
                return
            }
            
            touchNode.fillColor = .green
            
            if touchNode.name == "counterClockButton" {
                snake!.moveClockwise()
            } else if touchNode.name == "counterClockwiseButton" {
                snake!.moveCounterClockwise()
            }
        }
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        // кнопка будет серой после окончания нажатия
        for touch in touches {
            let touchLocation = touch.location(in: self)
            
            guard let touchNode = self.atPoint(touchLocation) as? SKShapeNode,
                  touchNode.name == "counterClockwiseButton" || touchNode.name == "counterClockButton" else {
                return
            }
            
            touchNode.fillColor = .gray
        }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        snake!.move()
    }
    
    private func start() {
        guard let scene = scene else { return }
        
        snake = Snake(atPoint: CGPoint(x: scene.frame.midX, y: scene.frame.midY)) // новая змейка
        self.addChild(snake!)
        
        createApple() // новое яблоко
        initButtons() // новые кнопки
    }
    // Новые функции
    private func stop() {
        snake = nil
        self.removeAllChildren()
    }
    
    // Функция рестарта
    private func restart() {
        stop()
        start()
    }
}

extension GameScene {
    
    func createApple() { // рандомные координаты для яблока
        
        let randX = CGFloat(arc4random_uniform(UInt32(view!.scene!.frame.maxX-5)))
        let randY = CGFloat(arc4random_uniform(UInt32(view!.scene!.frame.maxY-5)))
        
        let apple = Apple(position: CGPoint(x: randX, y: randY))
        
        self.addChild(apple)
    }
    
    func initButtons() {
        let counterClockwiseButton = SKShapeNode() // первая кнопка
        //размерность кнопки
        counterClockwiseButton.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 45, height: 45)).cgPath
        // позиция
        counterClockwiseButton.position = CGPoint(x: view!.scene!.frame.minX + 30, y: view!.scene!.frame.minY + 30)
        counterClockwiseButton.fillColor = .gray
        counterClockwiseButton.strokeColor = .gray
        counterClockwiseButton.lineWidth = 10
        counterClockwiseButton.name = "counterClockwiseButton"
        self.addChild(counterClockwiseButton)
        
        
        
        let counterClockButton = SKShapeNode() // вторая кнопка
        counterClockButton.path = UIBezierPath(ovalIn: CGRect(x: 0, y: 0, width: 45, height: 45)).cgPath
        counterClockButton.position = CGPoint(x: view!.scene!.frame.maxX - 80, y: view!.scene!.frame.minY + 30)
        counterClockButton.fillColor = .gray
        counterClockButton.strokeColor = .gray
        counterClockButton.lineWidth = 10
        counterClockButton.name = "counterClockButton"
        self.addChild(counterClockButton)
    }
    
}


extension GameScene: SKPhysicsContactDelegate {
    
    func didBegin(_ contact: SKPhysicsContact) {
        
        let bodyes = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask // логическая сумма 2-ч обьектов
        let collisionObject = bodyes - CollisionCategory.SnakeHead // обьект с которым столкнулась голова
        
        switch collisionObject { // столкновение с яблоком
        case CollisionCategory.Apple:
            
            let apple = contact.bodyA.node is Apple ? contact.bodyA.node : contact.bodyB.node
            snake?.addBodyPart()
            apple?.removeFromParent()
            createApple()
            
        case CollisionCategory.EdgeBody: // домашка
            restart()
           
        default:
            break
        }
        
        
    }
    
}
