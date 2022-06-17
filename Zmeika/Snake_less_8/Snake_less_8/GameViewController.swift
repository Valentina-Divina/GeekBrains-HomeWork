//
//  GameViewController.swift
//  Snake_less_8
//
//  Created by Valya on 13.06.2022.
//

import UIKit
import SpriteKit
import GameplayKit


class GameViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let scene = GameScene(size: view.bounds.size) // сцена, ее размер с экран
        let skView = view as! SKView // View должна быть класса SKView
        
        skView.showsFPS = true
        skView.showsNodeCount = true // количество обьектов
        skView.ignoresSiblingOrder = true // произвольный порядок рендеринга (объекты отрисовываются хаотично)
        
        scene.scaleMode = .resizeFill // растягиваем сцену на весь экран
        
        skView.presentScene(scene) // представление сцены на ViewController-е
 
    }
}

