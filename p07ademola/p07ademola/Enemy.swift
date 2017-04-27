//
//  Enemy.swift
//  p07ademola
//
//  Created by Lynda on 4/27/17.
//  Copyright © 2017 Lynda. All rights reserved.
//

import UIKit
import SpriteKit

class Enemy: SKSpriteNode {
    
    var enemyLocation = CGPoint(x: 0, y:0)

    init() {
        let texture = SKTexture(imageNamed: "robot_3Dblue")
        super.init(texture: texture, color: UIColor.blue, size: texture.size())
        self.name = "enemy"
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //fatalError("init(coder:) has not been implemented")
    }
    
    func anAction(scene: SKScene) {
        print("in a scened")
    }
}
