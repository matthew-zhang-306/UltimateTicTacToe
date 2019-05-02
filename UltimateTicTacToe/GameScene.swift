//
//  GameScene.swift
//  UltimateTicTacToe
//
//  Created by Zhang, Matthew on 4/17/19.
//  Copyright © 2019 friscoisd. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene
{
    
    override func didMove(to view: SKView)
    {
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        guard let touch = touches.first
        else
        {
            return
        }
        
        let touchLocation = touch.location(in: self)
        print(touchLocation)
    }
    
    
    override func update(_ currentTime: TimeInterval)
    {
        // Called before each frame is rendered
    }
}
