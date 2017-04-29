//
//  LevelScene.swift
//  p07ademola
//
//  Created by Lynda on 4/25/17.
//  Copyright © 2017 Lynda. All rights reserved.
//

import UIKit
import SpriteKit

//put value here to make it global
//maybe something to keep track to the level for the game
//var levelNum = 1
class LevelScene: SKScene {
    
    //var player : SKSpriteNode?
    let player:Player = Player()
    //will be making an array of enmies
    let enemy:Enemy = Enemy()
    
    //
    var toShoot = false
    
    override func didMove(to view: SKView) {
        //self.player = self.childNode(withName: "player") as? SKSpriteNode
        addChild(player)
        addChild(enemy)
        print("Now in LevelScene")
        enemy.anAction(scene: self)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //if let location = touches.first?.location(in: self) {
            //let touchedNode = nodes(at: location)
            toShoot = true
            
        //}
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        toShoot = false
        guard let touch = touches.first else { return }
        let currentPoint = touch.location(in: self)
        player.position = currentPoint
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        let point = touch.location(in: self)
        if(toShoot) {
            player.fireBullet(scene: self, location: point)
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        enemy.followPlayer(scene: self, playerPos: player.position)
    }
}
