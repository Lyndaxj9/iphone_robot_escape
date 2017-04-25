//
//  InstructScene.swift
//  p07ademola
//
//  Created by Lynda on 4/25/17.
//  Copyright © 2017 Lynda. All rights reserved.
//

import UIKit
import SpriteKit

class InstructScene: SKScene {

    override func didMove(to view: SKView) {
        print("Now in InstructScene")
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        if let location = touches.first?.location(in: self) {
            let touchedNode = nodes(at: location)
            
            if touchedNode[0].name == "next_button" {
                print("put up new scene")
                let transition = SKTransition.reveal(with: .down, duration: 1.0)
                
                let nextScene = SKScene(fileNamed: "LevelScene")
                nextScene?.scaleMode = .aspectFill
                scene?.view?.presentScene(nextScene!, transition: transition)
            }
        }

    }
}
