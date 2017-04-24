//
//  GameScene.swift
//  p07-ademola
//
//  Created by Lynda on 4/23/17.
//  Copyright © 2017 Lynda. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    //var textLabel:SKLabelNode!
    let textLabel = SKLabelNode(text: "Hello Robots")
    
    override func didMove(to view: SKView) {
        /*
        textLabel = SKLabelNode(fontNamed: "Chalkduster")
        textLabel.text = "Welcome to Robot Escape"
        textLabel.fontSize = 50
        textLabel.color = UIColor.black
        //textLabel.horizontalAlignmentMode = .center
 */
        textLabel.position = CGPoint(x: 50, y:100)

        addChild(textLabel)
    }
    
    
    func touchDown(atPoint pos : CGPoint) {

    }
    
    func touchMoved(toPoint pos : CGPoint) {

    }
    
    func touchUp(atPoint pos : CGPoint) {

    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {

    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
