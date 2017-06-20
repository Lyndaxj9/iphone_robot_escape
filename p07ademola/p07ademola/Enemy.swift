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
    
    private var moveSpeed = CGFloat(8)

    init() {
        let texture = SKTexture(imageNamed: "robot_3Dblue")
        super.init(texture: texture, color: UIColor.blue, size: texture.size())
        self.name = "enemy"
        self.position = CGPoint(x: 500, y: 0)
        self.zRotation = (180.0 * CGFloat(M_PI)) / 180.0
        self.xScale = 0.35
        self.yScale = 0.35
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func followPlayer(scene: SKScene, playerPos: CGPoint) {
        
        let agroRange = CGFloat(250.0)
        let distanceX = playerPos.x - self.position.x
        let distanceY = playerPos.y - self.position.y
        
        let distanceTotal = sqrt(distanceX*distanceX + distanceY*distanceY)
        
        let v = CGVector(dx:distanceX, dy: distanceY)
        let angle = atan2(v.dy, v.dx)
        self.zRotation = angle
        
        if( distanceTotal <= self.size.width) {
            //print("too close")
            
        } else if( distanceTotal <= agroRange ) {
            self.position.x += moveSpeed * cos(angle)
            self.position.y += moveSpeed * sin(angle)
    
        } else if( distanceTotal > agroRange ) {
            //print("idle movement")
        }
        //maybe another if statement for when they are super close like width of enemy sprite?
        
    }

}
