//
//  GameScene.swift
//  UltimateTicTacToe
//
//  Created by Zhang, Matthew on 4/17/19.
//  Copyright © 2019 friscoisd. All rights reserved.
//

import SpriteKit
import GameplayKit

class GameScene: SKScene {
    var o = SKSpriteNode(imageNamed: "O")
    var x = SKSpriteNode(imageNamed: "X")
    var otwo = SKSpriteNode(imageNamed: "O")
    var xtwo = SKSpriteNode(imageNamed: "X")

    
    var starto = 0
    var startx = 500
    var changey = 0
    var oThing = thing(posX: 0, posY: 0)
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.white
        
        
        oThing = weBuild(shape: o)
        
        //500 is around the top
        
        
        
    }
    func convertThing(item: thing) -> Int
    {
        return item.getX()
    }
    struct thing
    {
        var posX: Int
        var posY: Int
        
        func getX() -> Int
        {
            return posX
        }
        func getY() -> Int
        {
            return posY
        }
        mutating func decrementY()
        {
            posY = posY - 1
        }
        mutating func setX(value: Int)
        {
            posX = posX + value
           
        }
    }
    func weBuild(shape: SKSpriteNode) -> thing
    {
        
        shape.alpha = 0.5
        let startshape = startingSpot()
        let object = thing(posX: startshape, posY: 500)
        shape.position = CGPoint(x: startshape, y: 500)
        addChild(shape)
        return(object)
        
        
    }
    
    // Builds shape
   
    /*
    func build(shape: SKSpriteNode)
    {
        shape.alpha = 0.5
        let startshape = startingSpot()
        
        shape.position = CGPoint(x: startshape, y: 500)
        addChild(shape)
    }
    */
    func posOrNeg() -> Int
    {
        if(arc4random_uniform(UInt32(2)) == 1){
            return -1
        } else {
            return 1
        }
    }
    
    func startingSpot() -> Int
    {
        return 0
        // return Int(arc4random_uniform(UInt32(511))) * posOrNeg()
    }
    
    func newY() -> Int
    {
        
        changey = changey - 1
        return changey
    }
    
    func moveDown(item: SKSpriteNode, otherItem: thing)
    {
        
        let yValue = newY()
        
        if(yValue != -511) {
            item.position = CGPoint(x: convertThing(item: otherItem), y: yValue)
            
            
        } else {
            changey = 500
            item.position = CGPoint(x: convertThing(item: otherItem), y: yValue)
        }
        
    }
    
    override func update(_ currentTime: TimeInterval) {
        moveDown(item: o, otherItem: oThing)
        
    }
}
