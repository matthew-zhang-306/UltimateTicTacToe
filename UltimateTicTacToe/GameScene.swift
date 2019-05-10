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
    
    var scenePointToViewPoint: CGPoint = CGPoint(x: -UIScreen.main.bounds.width / 2, y: UIScreen.main.bounds.height / 2)
    
    override func didMove(to view: SKView)
    {
        drawBoardLines(startPos: CGPoint(x: 0, y: 0) + scenePointToViewPoint, squareSize: CGPoint(x: UIScreen.main.bounds.width / 9, y: UIScreen.main.bounds.height / 9))
    }
    
    func drawBoardLines(startPos: CGPoint, squareSize: CGPoint) {
        print(scenePointToViewPoint)
        
        var bigBoardLine = SKShapeNode()
        
        bigBoardLine.strokeColor = SKColor.white
        bigBoardLine.lineWidth = 10
        
        // Drawing the seperator lines for the big board
        var pathToDraw = CGMutablePath()
        pathToDraw.move(to: CGPoint(x: startPos.x, y: startPos.y + squareSize.y))
        pathToDraw.addLine(to: CGPoint(x: startPos.x + 3 * squareSize.x, y: startPos.y + squareSize.y))
        bigBoardLine.path = pathToDraw
        self.addChild(bigBoardLine)
        
        bigBoardLine = SKShapeNode()
        pathToDraw = CGMutablePath()
        pathToDraw.move(to: CGPoint(x: startPos.x, y: startPos.y + 2 * squareSize.y))
        pathToDraw.addLine(to: CGPoint(x: startPos.x + 3 * squareSize.x, y: startPos.y + 2 * squareSize.y))
        bigBoardLine.path = pathToDraw
        
        
        
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
