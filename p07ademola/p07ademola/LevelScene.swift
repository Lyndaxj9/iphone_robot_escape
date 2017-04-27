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
    
    override func didMove(to view: SKView) {
        //self.player = self.childNode(withName: "player") as? SKSpriteNode
        addChild(player)
        addChild(enemy)
        print("Now in LevelScene")
        enemy.anAction(scene: self)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let location = touches.first?.location(in: self) {
            let touchedNode = nodes(at: location)
            
            if touchedNode[0].name == "player" {
                print("we can move")
            }
        }
        
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let touch = touches.first else { return }
        //player.position = touch.location(in: self)
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
}
