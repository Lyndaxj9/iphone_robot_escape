//
//  Points.swift
//  p07ademola
//
//  Created by Lynda on 4/27/17.
//  Copyright © 2017 Lynda. All rights reserved.
//

import UIKit
import SpriteKit

class Points: SKSpriteNode {
    
    init() {
        let texture = SKTexture(imageNamed: "barrelGrey_up")
        super.init(texture: texture, color: UIColor.gray, size: texture.size())
        self.name = "points"
        self.physicsBody = SKPhysicsBody(texture: texture, size: texture.size())
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.affectedByGravity = false
        self.physicsBody?.usesPreciseCollisionDetection = true
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        //fatalError("init(coder:) has not been implemented")
    }
}
