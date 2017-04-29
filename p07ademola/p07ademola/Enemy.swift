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
    
    private var moveSpeed = CGFloat(200)

    init() {
        let texture = SKTexture(imageNamed: "robot_3Dblue")
        super.init(texture: texture, color: UIColor.blue, size: texture.size())
        self.name = "enemy"
        self.position = CGPoint(x: 500, y: 0)
        self.zRotation = (180.0 * CGFloat(M_PI)) / 180.0
        self.xScale = 0.5
        self.yScale = 0.5
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func followPlayer(scene: SKScene, playerPos: CGPoint) {
        
        let agroRange = CGFloat(400.0)
        let distanceX = playerPos.x - self.position.x
        let distanceY = playerPos.y - self.position.y
        
        let distanceTotal = sqrt(distanceX*distanceX + distanceY*distanceY)
        
        if( distanceTotal <= agroRange ) {
            let moveX = moveSpeed/distanceX
            let moveY = moveSpeed/distanceY
            
            let newPosX = self.position.x + moveX
            let newPosY = self.position.y + moveY
            
            self.position.x = newPosX
            self.position.y = newPosY
            
            print("follow")
        }
        //maybe another if statement for when they are super close like width of enemy sprite?
        
    }
    
    func anAction(scene: SKScene) {
        print("in a scened")
    }
}
