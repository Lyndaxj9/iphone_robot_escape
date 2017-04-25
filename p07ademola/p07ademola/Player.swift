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
  
    
    /*
    convenience init() {
        let texture = SKTexture(imageNamed: "robot_red")
        //super.init(texture: texture, color: UIColor.red, size: texture.size())
        self.init()
        self.texture = texture
        self.name = "player"
    }
 */
    init() {
        let texture = SKTexture(imageNamed: "robot_red")
        super.init(texture: texture, color: UIColor.red, size: texture.size())
        self.name = "player"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //fatalError("init(coder:) has not been implemented")
    }
 
    
    func startAction() {
        self.run(SKAction.moveBy(x: 30, y: 30, duration: 2.0))
    }
}
