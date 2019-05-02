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
    
    var bigBoardLines = SKShapeNode()
    var pathToDraw = CGMutablePath()
    
    override func didMove(to view: SKView)
    {
        // Drawing the seperator lines for the big board
        pathToDraw.move(to: CGPoint(x: 100.0, y: 100.0))
        pathToDraw.addLine(to: CGPoint(x: 50.0, y: 50.0))
        bigBoardLines.path = pathToDraw
        bigBoardLines.strokeColor = SKColor.white
        self.addChild(bigBoardLines)
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
