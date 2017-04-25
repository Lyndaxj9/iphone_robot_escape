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
    
    override func didMove(to view: SKView) {
        //self.player = self.childNode(withName: "player") as? SKSpriteNode
        addChild(player)
        print("Now in LevelScene")
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        
    }
}
