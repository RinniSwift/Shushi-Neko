//
//  GameScene.swift
//  SushiNeko
//
//  Created by Rinni Swift on 10/4/18.
//  Copyright © 2018 Rinni Swift. All rights reserved.
//

import SpriteKit

enum Side {
    case left, right, none
}

class GameScene: SKScene {
    
    var sushiBasePiece: SushiPiece!
    var sushiTower: [SushiPiece] = []
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        sushiBasePiece = childNode(withName: "sushiBasePiece") as! SushiPiece
        sushiBasePiece.connectChopsticks()
        
        addTowerPiece(side: .none)
        addTowerPiece(side: .left)
        
        addRandomPieces(total: 10)
    }
    
    func addTowerPiece(side: Side) {
        // copy original sushiBasePiece
        let newPiece = sushiBasePiece.copy() as! SushiPiece
        newPiece.connectChopsticks()
        
        // access last piece properties
        let lastPiece = sushiTower.last
        
        // add ontop of last piece, default on first piece
        let lastPosition = lastPiece?.position ?? sushiBasePiece.position
        newPiece.position.x = lastPosition.x
        newPiece.position.y = lastPosition.y + 55
        
        // increment z to ensure it's ontop of the last piece, default on first piece
        let lastZPosition = lastPiece?.zPosition ?? sushiBasePiece.zPosition
        newPiece.zPosition = lastZPosition + 1
        
        // set side
        newPiece.side = side
        
        // add sushi to scene
        addChild(newPiece)
        
        // add sushi piece to sushi tower
        sushiTower.append(newPiece)
    }
    
    func addRandomPieces(total: Int) {
        for _ in 1...total {
            // access the last piece properties
            let lastPiece = sushiTower.last!
            
            // make sure we don't create back structures of the sushi
            if lastPiece.side != .none {
                addTowerPiece(side: .none)
            } else {
                let rand = arc4random_uniform(100)
                
                // 45% chance of left side, 45% chance of right side, 10% chance of no sides
                if rand < 45 {
                    addTowerPiece(side: .left)
                } else if rand < 90 {
                    addTowerPiece(side: .right)
                } else {
                    addTowerPiece(side: .none)
                }
            }
        }
    }
    
}
