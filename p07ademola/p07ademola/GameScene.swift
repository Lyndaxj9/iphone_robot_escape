//
//  GameScene.swift
//  p07ademola
//
//  Created by Lynda on 4/24/17.
//  Copyright © 2017 Lynda. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    
    private var startButton : SKSpriteNode?
    
    override func didMove(to view: SKView) {
        
        //fade in start button onto screen
        self.startButton = self.childNode(withName: "start_button") as? SKSpriteNode
        if let startButton = self.startButton {
            startButton.alpha = 0.0
            startButton.run(SKAction.fadeIn(withDuration: 4.0))
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //here switch to the next scene
        
        if let location = touches.first?.location(in: self) {
            let touchedNode = nodes(at: location)
            
            if touchedNode.count != 0 {
                if touchedNode[0].name == "start_button" {
                    print("put up new scene")
                    let transition = SKTransition.reveal(with: .down, duration: 1.0)
                    
                    let nextScene = SKScene(fileNamed: "InstructScene")
                    //let nextScene = InstructScene
                    nextScene?.scaleMode = .aspectFill
                    
                    scene?.view?.presentScene(nextScene!, transition: transition)
                } 
            }
            
        }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
