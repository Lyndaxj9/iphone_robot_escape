//
//  Bullet.swift
//  p07ademola
//
//  Created by Lynda on 4/25/17.
//  Copyright © 2017 Lynda. All rights reserved.
//

import UIKit
import SpriteKit

class Bullet: SKSpriteNode {

    private var fireDistX = CGFloat(450)
    private var fireDistY = CGFloat(175)
    
    init(bulletSound: String?) {
        let texture = SKTexture(imageNamed: "bulletYellowSilver_outline")
        super.init(texture: texture, color: UIColor.blue, size: texture.size())
        self.name = "bullet"
        
        if(bulletSound != nil){
            run(SKAction.playSoundFileNamed(bulletSound!, waitForCompletion: false))
        }
        
        self.physicsBody = SKPhysicsBody(texture: texture, size: texture.size())
        self.physicsBody?.isDynamic = true
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.affectedByGravity = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func getFireDistX() -> CGFloat {
        return fireDistX
    }
    
    func getFireDistY() -> CGFloat {
        return fireDistY
    }
}
