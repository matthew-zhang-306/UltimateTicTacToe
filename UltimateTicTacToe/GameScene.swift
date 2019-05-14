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
    var scenePointToViewPoint: CGPoint!
    var screenSize: CGRect!
    var startingY: CGFloat!
    
    func toScenePoint(_ point: CGPoint) -> CGPoint {
        return CGPoint(x: point.x, y: -point.y) + scenePointToViewPoint
    }
    
    override func didMove(to view: SKView)
    {
        drawBoardLines(at: CGPoint(x: 0, y: startingY), width: screenSize.width, halfPadding: 0)
        for yIndex in 0...2 {
            for xIndex in 0...2 {
                let Y = CGFloat(yIndex)
                let X = CGFloat(xIndex)
                drawBoardLines(at: CGPoint(x: X * screenSize.width / 3, y: Y * screenSize.width / 3 + startingY), width: screenSize.width / 3, halfPadding: 10)
            }
        }
    }
    
    func drawBoardLines(at startPos: CGPoint, width boardWidth: CGFloat, halfPadding: CGFloat) {
        drawLine(from: CGPoint(
            x: startPos.x + halfPadding,
            y: startPos.y + boardWidth / 3
        ), to: CGPoint(
            x: startPos.x + boardWidth - halfPadding,
            y: startPos.y + boardWidth / 3
        ))
        
        drawLine(from: CGPoint(
            x: startPos.x + halfPadding,
            y: startPos.y + 2 * boardWidth / 3
        ), to: CGPoint(
            x: startPos.x + boardWidth - halfPadding,
            y: startPos.y + 2 * boardWidth / 3
        ))
        
        drawLine(from: CGPoint(
            x: startPos.x + boardWidth / 3,
            y: startPos.y + halfPadding
        ), to: CGPoint(x:
            startPos.x + boardWidth / 3,
            y: startPos.y + boardWidth - halfPadding
        ))
        
        drawLine(from: CGPoint(
            x: startPos.x + 2 * boardWidth / 3,
            y: startPos.y + halfPadding
        ), to: CGPoint(
            x: startPos.x + 2 * boardWidth / 3,
            y: startPos.y + boardWidth - halfPadding
        ))
    }
    
    func drawLine(from start: CGPoint, to end: CGPoint) {
        let line = SKShapeNode()
        line.strokeColor = SKColor.white
        line.lineWidth = 3
        
        let path = CGMutablePath()
        path.move(to: toScenePoint(start))
        path.addLine(to: toScenePoint(end))
        line.path = path
        
        self.addChild(line)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?)
    {
        guard let touch = touches.first
        else
        {
            return
        }
        
        let touchLocation = touch.location(in: self)
        print(touchLocation - scenePointToViewPoint)
    }
    
    
    override func update(_ currentTime: TimeInterval)
    {
        // Called before each frame is rendered
    }
}
