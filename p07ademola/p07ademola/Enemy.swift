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
    private var idleSpeed = CGFloat(100)
    private var alive = true
    private var idling = false
    private var pointValue = 20

    init() {
        let texture = SKTexture(imageNamed: "robot_3Dblue")
        super.init(texture: texture, color: UIColor.blue, size: texture.size())
        self.name = "enemy"
        self.position = CGPoint(x: 500, y: 0)
        self.zRotation = (180.0 * CGFloat(M_PI)) / 180.0
        self.xScale = 0.35
        self.yScale = 0.35
        let textureSize = texture.size()
        let xSize = textureSize.width * self.xScale
        let ySize = textureSize.height * self.yScale
        self.physicsBody = SKPhysicsBody(texture: texture, size: CGSize(width: xSize, height: ySize))
        self.physicsBody?.isDynamic = true
        self.physicsBody?.allowsRotation = false
        self.physicsBody?.affectedByGravity = false
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func enemyDeath(scene: SKScene) {
        print("enemyDeath")
        alive = false
        let fadeOut = SKAction.fadeOut(withDuration: 0.5)
        let removeNode = SKAction.removeFromParent()
        let seq = SKAction.sequence([fadeOut, removeNode])
        self.run(seq)
    }
    
    func followPlayer(scene: SKScene, playerPos: CGPoint) {
        
        if(alive){
            let agroRange = CGFloat(275.0)
            let distanceX = playerPos.x - self.position.x
            let distanceY = playerPos.y - self.position.y
            
            let distanceTotal = sqrt(distanceX*distanceX + distanceY*distanceY)
            
            let v = CGVector(dx:distanceX, dy: distanceY)
            let angle = atan2(v.dy, v.dx)
            self.zRotation = angle
            
            if( distanceTotal <= agroRange ) {
                idling = false
                self.removeAction(forKey: "idling")
                self.position.x += moveSpeed * cos(angle)
                self.position.y += moveSpeed * sin(angle)
                
            } else if( distanceTotal > agroRange ) {
                if(!idling){
                    print("idle movement")
                    idleMove()
                    idling = true
                }

            }
            //maybe another if statement for when they are super close like width of enemy sprite?
        }
    }
    
    func idleMove() {
        let move = SKAction.moveBy(x: -idleSpeed, y: idleSpeed*0.3, duration: 1.8)
        let wait = SKAction.wait(forDuration: 0.7)
        let idleWalkSeq = SKAction.sequence([wait, move, wait, move.reversed()])
        self.run(SKAction.repeatForever(idleWalkSeq), withKey: "idling")
    }
    
    func isAlive() -> Bool {
        return alive
    }
    
    func getPointValue() -> Int {
        return pointValue
    }

}
