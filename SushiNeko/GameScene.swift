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
    
    override func didMove(to view: SKView) {
        super.didMove(to: view)
        
        sushiBasePiece = childNode(withName: "sushiBasePiece") as! SushiPiece
        sushiBasePiece.connectChopsticks()
    }
    
}
