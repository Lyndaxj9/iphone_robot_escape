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
    
    private var canFire = true
    
    init() {
        let texture = SKTexture(imageNamed: "robot_3Dyellow")
        super.init(texture: texture, color: UIColor.yellow, size: texture.size())
        self.name = "player"
        self.position = CGPoint(x:-500, y: 0)
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
    
    func fireBullet(scene: SKScene, location: CGPoint) {
        if(!canFire){
            return
        } else {
            canFire = false
            //x: 530 y: 250
            let bullet = Bullet(bulletSound: "laser5")
            var fireLocX = CGFloat(450)
            var fireLocY = CGFloat(175)
            
            bullet.position.x = self.position.x + self.size.width/2
            bullet.position.y = self.position.y
            scene.addChild(bullet)
            
            if(location.x < fireLocX) {
                fireLocX = location.x
            }
            if(location.y < fireLocY) {
                fireLocY = location.y
            }
            
            //let slope = (self.position.y - fireLocY)/(self.position.x - fireLocX)
            let v2 = CGVector(dx:fireLocX - self.position.x, dy: fireLocY - self.position.y)
            let angle = atan2(v2.dy, v2.dx)
            bullet.zRotation = angle
            
            let rotatePlayer = SKAction.rotate(toAngle: angle, duration: 0.1)
            let moveBulletAction = SKAction.move(to: CGPoint(x:fireLocX, y:fireLocY), duration: 1.0)
            let removeBulletAction = SKAction.removeFromParent()
            self.run(rotatePlayer)
            bullet.run(SKAction.sequence([moveBulletAction, removeBulletAction]))
            let waitToEnableFire = SKAction.wait(forDuration: 0.5)
            run(waitToEnableFire, completion: {
                self.canFire = true
            })
            
            print("shoot bullet")
        }
    }
 
}
