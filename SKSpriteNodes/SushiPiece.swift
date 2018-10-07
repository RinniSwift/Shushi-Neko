//
//  SushiPiece.swift
//  SushiNeko
//
//  Created by Rinni Swift on 10/4/18.
//  Copyright © 2018 Rinni Swift. All rights reserved.
//

import SpriteKit

class SushiPiece: SKSpriteNode {
    // chopstick objects
    var leftChopstick: SKSpriteNode!
    var rightChopstick: SKSpriteNode!
    
    var side: Side = .none {
        didSet {
            switch side {
            case .left:
                /* Show left chopstick */
                leftChopstick.isHidden = false
            case .right:
                /* Show right chopstick */
                rightChopstick.isHidden = false
            case .none:
                /* Hide all chopsticks */
                leftChopstick.isHidden = true
                rightChopstick.isHidden = true
            }
        }
    }
    
    func connectChopsticks() {
        rightChopstick = childNode(withName: "rightChopstick") as! SKSpriteNode
        leftChopstick = childNode(withName: "leftChopstick") as! SKSpriteNode
        side = .none
    }
    
    /* You are required to implement this for your subclass to work */
    override init(texture: SKTexture?, color: UIColor, size: CGSize) {
        super.init(texture: texture, color: color, size: size)
    }
    
    /* You are required to implement this for your subclass to work */
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    func flip(_ side: Side) {
        var actionName: String = ""
        if side == .left {
            actionName = "FlipRight"
        } else if side == .right {
            actionName = "FlipLeft"
        }
        let flip = SKAction(named: actionName)!
        let remove = SKAction.removeFromParent()
        let sequence = SKAction.sequence([flip, remove])
        run(sequence)
    }
}
