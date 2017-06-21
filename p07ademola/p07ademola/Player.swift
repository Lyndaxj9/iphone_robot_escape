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
    private var moveSpeed = CGFloat(16)
    
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
    
    func moveTo(scene: SKScene, location: CGPoint) {
        moveX(point: location.x)
        moveY(point: location.y)
        let angle = calculateAngle(x1: self.position.x, x2: location.x, y1: self.position.y, y2: location.y)
        let rotatePlayer = SKAction.rotate(toAngle: angle, duration: 0.1)
        self.run(rotatePlayer)
    }
    
    func moveX(point: CGFloat) {
        if(abs(self.position.x - point) < moveSpeed) {
            self.position.x = point
        } else {
            if (point < self.position.x) {
                self.position.x -= moveSpeed
            } else {
                self.position.x += moveSpeed
            }
        }
        
    }
    
    func moveY(point: CGFloat) {
        if(abs(self.position.y - point) < moveSpeed) {
            self.position.y = point
        } else {
            if (point < self.position.y) {
                self.position.y -= moveSpeed
            } else {
                self.position.y += moveSpeed
            }
        }
    }
    
    func fireBullet(scene: SKScene, location: CGPoint) {
        if(!canFire){
            return
        } else {
            canFire = false
 
            let bullet = Bullet(bulletSound: "laser5")
            var fireLocX = bullet.getFireDistX()
            var fireLocY = bullet.getFireDistY()
            
            bullet.physicsBody?.categoryBitMask = PhysicsCategory.Bullet
            bullet.physicsBody?.contactTestBitMask = PhysicsCategory.EnemyRobot
            bullet.position.x = self.position.x + self.size.width/2
            bullet.position.y = self.position.y
            scene.addChild(bullet)
            
            //restrict how far the bullet can go
            let dV = CGVector(dx: location.x - self.position.x, dy: location.y - self.position.y)
            let vRoot = sqrt(pow(dV.dx, 2) + pow(dV.dy, 2))
            let uX = dV.dx/vRoot
            let uY = dV.dy/vRoot
            
            if(abs(self.position.x - location.x) < bullet.getFireDistX()) {
                fireLocX = location.x
            } else {
                //fireLocX += self.position.x
                fireLocX *= uX
            }
            
            if(abs(self.position.y - location.y) < bullet.getFireDistY()) {
                fireLocY = location.y
            } else {
                //fireLocY += self.position.y
                fireLocY *= uY
            }
            
            //let slope = (self.position.y - fireLocY)/(self.position.x - fireLocX)
            /*
            let v2 = CGVector(dx:fireLocX - self.position.x, dy: fireLocY - self.position.y)
 */
            let angle = calculateAngle(x1: self.position.x, x2: fireLocX, y1: self.position.y, y2: fireLocY)
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
    
    func calculateAngle(x1: CGFloat, x2: CGFloat, y1: CGFloat, y2: CGFloat) -> CGFloat {
        let v2 = CGVector(dx:x2 - x1, dy: y2 - y1)
        let angle = atan2(v2.dy, v2.dx)
        return angle
    }
 
}
