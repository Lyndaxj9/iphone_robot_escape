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
    
    private var label : SKLabelNode?
    private var spinnyNode : SKShapeNode?
    private var startButton : SKSpriteNode?
    var textLabel = SKLabelNode(text: "Robot Escape")
    
    override func didMove(to view: SKView) {
        
        //fade in start button onto screen
        self.startButton = self.childNode(withName: "start_button") as? SKSpriteNode
        if let startButton = self.startButton {
            startButton.alpha = 0.0
            startButton.run(SKAction.fadeIn(withDuration: 4.0))
        }
        
        textLabel.fontSize = 50
        addChild(textLabel)
        
        // Create shape node to use during mouse interaction
        let w = (self.size.width + self.size.height) * 0.05
        self.spinnyNode = SKShapeNode.init(rectOf: CGSize.init(width: w, height: w), cornerRadius: w * 0.3)
        
        if let spinnyNode = self.spinnyNode {
            spinnyNode.lineWidth = 2.5
            
            spinnyNode.run(SKAction.repeatForever(SKAction.rotate(byAngle: CGFloat(M_PI), duration: 1)))
            spinnyNode.run(SKAction.sequence([SKAction.wait(forDuration: 0.5),
                                              SKAction.fadeOut(withDuration: 0.5),
                                              SKAction.removeFromParent()]))
        }
    }
    
    
    func touchDown(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.green
            self.addChild(n)
        }
    }
    
    func touchMoved(toPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.blue
            self.addChild(n)
        }
    }
    
    func touchUp(atPoint pos : CGPoint) {
        if let n = self.spinnyNode?.copy() as! SKShapeNode? {
            n.position = pos
            n.strokeColor = SKColor.red
            self.addChild(n)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        //here switch to the next scene
        
        if let location = touches.first?.location(in: self) {
            let touchedNode = nodes(at: location)
            
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
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchMoved(toPoint: t.location(in: self)) }
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    override func touchesCancelled(_ touches: Set<UITouch>, with event: UIEvent?) {
        for t in touches { self.touchUp(atPoint: t.location(in: self)) }
    }
    
    
    override func update(_ currentTime: TimeInterval) {
        // Called before each frame is rendered
    }
}
