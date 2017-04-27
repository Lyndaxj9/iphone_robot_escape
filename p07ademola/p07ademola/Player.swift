//
//  Player.swift
//  p07ademola
//
//  Created by Lynda on 4/25/17.
//  Copyright © 2017 Lynda. All rights reserved.
//

import UIKit
import SpriteKit

class Player: SKSpriteNode {
    
    init() {
        let texture = SKTexture(imageNamed: "robot_3Dyellow")
        super.init(texture: texture, color: UIColor.yellow, size: texture.size())
        self.name = "player"
        self.position = CGPoint(x:-300, y: 0)
        animate()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //fatalError("init(coder:) has not been implemented")
    }
    
    private func animate() {
        self.run(SKAction.moveBy(x: -30, y: 0, duration: 2.0))
    }
 
    
    func doSomething(scene: SKScene) {
        print("I did something")
    }
}
