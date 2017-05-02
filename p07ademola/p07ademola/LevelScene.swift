//
//  LevelScene.swift
//  p07ademola
//
//  Created by Lynda on 4/25/17.
//  Copyright © 2017 Lynda. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit

struct PhysicsCategory {
    static let None     : UInt32 = 0
    static let All      : UInt32 = UInt32.max
    static let PlayerRobot : UInt32 = 0b1 //1
    static let EnemyRobot  : UInt32 = 0b10 //2
    static let PathEdge    : UInt32 = 0b11 //3
    static let PointObject : UInt32 = 0b100 //4
}

//put value here to make it global
//maybe something to keep track to the level for the game
//var levelNum = 1
class LevelScene: SKScene, SKPhysicsContactDelegate {
    
    //tileMap to be created with objects
    var objectTileMap:SKTileMapNode!
    var pathTilesMap:SKTileMapNode!
    var backgroundMap:SKTileMapNode!
    var barrierMap:SKTileMapNode!
    
    //var player : SKSpriteNode?
    let player:Player = Player()
    //will be making an array of enmies
    let enemy:Enemy = Enemy()
    
    //determine whether to shoot or to move
    var toShoot = false
    
    //determine
    var toMove = true
    
    var score = 0
    
    override func didMove(to view: SKView) {
        physicsBody = SKPhysicsBody(edgeLoopFrom: frame)
        physicsWorld.contactDelegate = self
        setupPlayer()
        setupEnemy()
        loadNodes()
        setupObjects()
        print("Now in LevelScene")
        
    }
    
    func setupPlayer() {
        player.physicsBody?.categoryBitMask = PhysicsCategory.PlayerRobot
        player.physicsBody?.contactTestBitMask = PhysicsCategory.PathEdge | PhysicsCategory.PointObject | PhysicsCategory.EnemyRobot
        player.physicsBody?.collisionBitMask = PhysicsCategory.PathEdge
        player.physicsBody?.usesPreciseCollisionDetection = true
        addChild(player)
    }
    
    func setupEnemy() {
        addChild(enemy)
    }
    
    func loadNodes() {
        guard let backgroundMap = childNode(withName: "groundMap") as? SKTileMapNode else {
            fatalError("Background node not loaded")
        }
        self.backgroundMap = backgroundMap
        
        guard let pathTilesMap = childNode(withName: "pathMap") as? SKTileMapNode else{
            fatalError("Path node not loaded")
        }
        self.pathTilesMap = pathTilesMap
        
        guard let barrierMap = childNode(withName: "barrierMap") as? SKTileMapNode else{
            fatalError("Barrier node not loaded")
        }
        self.barrierMap = barrierMap
        
        tileMapPhysics(name: self.barrierMap, dataString: "greyTile", categoryMask: PhysicsCategory.PathEdge, collisionMask: PhysicsCategory.PlayerRobot)
    }
    
    func setupObjects() {
        let columns = 21
        let rows = 12
        let size = CGSize(width: 64, height:64)
        
        guard let tileSet = SKTileSet(named: "Object Tiles") else {
            fatalError("Object Tiles Tile Set no found")
        }
    
        objectTileMap = SKTileMapNode(tileSet: tileSet, columns: columns, rows: rows, tileSize: size)
        addChild(objectTileMap)
        objectTileMap.name = "objectMap"
        
        let tileGroups = tileSet.tileGroups
        
        guard let barrelTile = tileGroups.first(where: {$0.name == "greybarrelTop"}) else {
            fatalError("No Barrel Tile Definition Found")
        }

        let numberOfObjects = 15
        
        for _ in 1...numberOfObjects {
            let column = Int(arc4random_uniform(UInt32(columns)))
            let row = Int(arc4random_uniform(UInt32(rows)))
            
            let pathTile = pathTilesMap.tileDefinition(atColumn: column, row: row)
            
            if(pathTile != nil) {
                let tile = barrelTile
                
                objectTileMap.setTileGroup(tile, forColumn: column, row: row)
            }
        }
        
        tileMapPhysics(name: objectTileMap, dataString: "barrel", categoryMask: PhysicsCategory.PointObject, collisionMask: PhysicsCategory.None)
        
    }
    
    func tileMapPhysics(name: SKTileMapNode, dataString: NSString, categoryMask: UInt32, collisionMask: UInt32) {
        let tileMap = name
        
        let tileSize = tileMap.tileSize
        let halfWidth = CGFloat(tileMap.numberOfColumns)/2.0 * tileSize.width //this confuses me
        let halfHeight = CGFloat(tileMap.numberOfRows)/2.0 * tileSize.height
        
        for col in 0..<tileMap.numberOfColumns {
            for row in 0..<tileMap.numberOfRows {
                if let tileDefinition = tileMap.tileDefinition(atColumn: col, row: row) {
                    let isHitTile = tileDefinition.userData?[dataString] as? Int
                    if(isHitTile != 0) {
                        //print("tilehitget")
                        let tileArray = tileDefinition.textures
                        let tileTexture = tileArray[0]
                        
                        let x = CGFloat(col)*tileSize.width - halfWidth + (tileSize.width/2)
                        let y = CGFloat(row)*tileSize.height - halfHeight + (tileSize.height/2)
                        
                        let tileNode = SKNode()
                        
                        tileNode.position = CGPoint(x:x, y:y)
                        tileNode.physicsBody = SKPhysicsBody(texture: tileTexture, size:CGSize(width: (tileTexture.size().width), height: (tileTexture.size().height))) //why *2
                        tileNode.physicsBody?.linearDamping = 60.0
                        tileNode.physicsBody?.affectedByGravity = false
                        tileNode.physicsBody?.allowsRotation = false
                        tileNode.physicsBody?.restitution = 0.0
                        tileNode.physicsBody?.isDynamic = false
                        
                        tileNode.physicsBody?.categoryBitMask = categoryMask
                        tileNode.physicsBody?.contactTestBitMask = PhysicsCategory.PlayerRobot | PhysicsCategory.EnemyRobot
                        tileNode.physicsBody?.collisionBitMask = collisionMask
                        tileNode.name = "groundHit"
                        tileNode.yScale = tileMap.yScale
                        tileNode.xScale = tileMap.xScale
                        
                        //tileMap.addChild(tileNode)
                        addChild(tileNode)
                    }
                }
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        toShoot = true
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
    
    func didBegin(_ contact: SKPhysicsContact) {
        let contactMask = contact.bodyA.categoryBitMask | contact.bodyB.categoryBitMask
        
        switch(contactMask) {
        case PhysicsCategory.PlayerRobot | PhysicsCategory.PointObject:
            
            //try moving around this code to make to make it so that the barrel disappears and the
            //points only increment once
            print("gain a point2")
            let position = player.position
            
            let column = objectTileMap.tileColumnIndex(fromPosition: position)
            let row = objectTileMap.tileRowIndex(fromPosition: position)
           
            objectTileMap.setTileGroup(nil, forColumn: column, row: row)
            
            if(contact.bodyA.node?.name == "groundHit") {
                print("remove this bodyA")
                contact.bodyA.node?.removeFromParent()
                score += 10
                print("score is: %d", score)
                
                
                objectTileMap.setTileGroup(nil, forColumn: column, row: row)
            } else if( contact.bodyB.node?.name == "groundHit") {
                print("remove this bodyB")
                contact.bodyB.node?.removeFromParent()
                score += 10
                print("score is: %d", score)
            
                
                objectTileMap.setTileGroup(nil, forColumn: column, row: row)
            }

            
        default:
            print("default")
        }
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        enemy.followPlayer(scene: self, playerPos: player.position)
    }
}
