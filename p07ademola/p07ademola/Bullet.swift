//
//  Bullet.swift
//  p07ademola
//
//  Created by Lynda on 4/25/17.
//  Copyright © 2017 Lynda. All rights reserved.
//

import UIKit
import SpriteKit

class Bullet: SKSpriteNode {

    init(bulletSound: String?) {
        let texture = SKTexture(imageNamed: "blue_button00")
        super.init(texture: texture, color: UIColor.blue, size: texture.size())
        self.name = "bullet"
        
        if(bulletSound != nil){
            run(SKAction.playSoundFileNamed(bulletSound!, waitForCompletion: false))
        }
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
}
