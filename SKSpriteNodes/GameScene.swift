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
    var character: Character!
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        sushiBasePiece = childNode(withName: "sushiBasePiece") as! SushiPiece
        sushiBasePiece.connectChopsticks()
        character = childNode(withName: "character") as! Character
        
        addTowerPiece(side: .none)
        addTowerPiece(side: .left)
        
        addRandomPieces(total: 10)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // called when only a single touch begins
        let touch = touches.first!
        // get the touch position
        let location = touch.location(in: self)
        //locate which half of the screen was touched
        if location.x > size.width / 2 {
            character.side = .right
        } else {
            character.side = .left
        }
        if let firstPiece = sushiTower.first as SushiPiece? {
            sushiTower.removeFirst()
            firstPiece.flip(character.side)
            addRandomPieces(total: 1)
        }
    }
    
    override func update(_ currentTime: TimeInterval) {
        moveTowerDown()
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
    
    func moveTowerDown() {
        var n: CGFloat = 0
        for piece in sushiTower {
            let y = (n * 55) + 215
            piece.position.y -= (piece.position.y - y) * 0.5
            n += 1
        }
    }
    
}
