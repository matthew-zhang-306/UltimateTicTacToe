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
    var xTwo = SKSpriteNode(imageNamed: "X")
    var oTwo = SKSpriteNode(imageNamed: "O")
    var oThree = SKSpriteNode(imageNamed: "O")
    var xThree = SKSpriteNode(imageNamed: "X")
    var xfirstLoop = 0
    var xsecondLoop = 0
    var xlooped = 0
    var firstLoop = 0
    var secondLoop = 0
    var looped = 0
    var starto = 0
    var startx = 500
    var changey = 0
     var decider = 0
    var xThing = thing(posX: 0, posY: 0, array: [])
    var oThing = thing(posX: 0, posY: 0, array: [])
    var xTwoThing = thing(posX: 0, posY: 0, array: [])
    var oTwoThing = thing(posX: 0, posY: 0, array: [])
    var xThreeThing = thing(posX: 0, posY: 0, array: [])
    var oThreeThing = thing(posX: 0, posY: 0, array: [])
    var looper = 0
    
    override func didMove(to view: SKView) {
        backgroundColor = SKColor.white
        
        oTwoThing = weBuild(shape: oTwo)

        xTwoThing = weBuild(shape: xTwo)
        oThing = weBuild(shape: o)
        xThing = weBuild(shape: x)
        xThreeThing = weBuild(shape: xThree)
        oThreeThing = weBuild(shape: oThree)
        //500 is around the top
        
        
        
    }
    func makeRandom() -> Array<Int>
    {
        let first = randomX() * posOrNeg()
        let second = randomX() * posOrNeg()
        let third = randomX() * posOrNeg()
        let fourth = randomX() * posOrNeg()
        return [first, second, third, fourth]
    }
    func randomX() -> Int
    {
        var threeDigit: Int
        let firstDigit = Int(arc4random_uniform(UInt32(4))) * 100
        let secondDigit = Int(arc4random_uniform(UInt32(10))) * 10
        let thirdDigit = Int(arc4random_uniform(UInt32(10)))
        threeDigit = firstDigit + secondDigit + thirdDigit
        if(drand48() >= 0.5)
        {
            threeDigit = threeDigit * -1
        }
        return threeDigit
    }
    
    func convertThing(item: thing) -> Int
    {
        return item.getX()
    }
    struct thing
    {
        var posX: Int
        var posY: Int
        var array: Array<Int>
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
            posX = posX - posX
            posX = posX + value
           
        }
        func getArray() -> Array<Int>
        {
            return array
        }
       
    }
    func weBuild(shape: SKSpriteNode) -> thing
    {
        
        shape.alpha = 0.5
        let startshape = randomX()
        let object = thing(posX: startshape, posY: 500, array: makeRandom())
        shape.position = CGPoint(x: startshape, y: 500)
        addChild(shape)
        return(object)
        
        
    }
    
    
    func posOrNeg() -> Int
    {
        if(drand48()  >= 0.5){
            
            return -1
        } else {
            
            return 1
        }
    }
    
    func randomSpeed() -> Int
    {
       
        return (Int(arc4random_uniform(UInt32(5))))+1
    }
    
    func newY() -> Int
    {
        let speed = randomSpeed()
        changey = changey - speed
        return changey
    }
    func movedown(item: SKSpriteNode, theItem: thing)
    {
        let yValue = newY()
        let theArray = theItem.getArray()
        
       
        if(looper == 0)
        {
            looper = 1
        }
        
        if(decider == 0)
        {
            if(yValue >= -511)
            {
                
                item.position = CGPoint(x: convertThing(item: theItem), y: yValue)
            } else {
                
                item.position = CGPoint(x: theArray[looper], y: 511)
                decider = 1
                changey = 511
            }
        }
        
        if(decider == 1)
        {
            if(yValue >= -511)
            {
                print("\(theArray[looper])")
                item.position = CGPoint(x: theArray[looper], y: yValue)
                
                
            } else {
                if(theArray.count-1 != looper)
                {
                    
                    looper = looper + 1
                } else {
                    
                    looper = 0
                }
                
                item.position = CGPoint(x: theArray[looper], y: 511)
                changey = 511
            }
        }
    }
    
   
    
        
    
    
    override func update(_ currentTime: TimeInterval) {
        movedown(item: x, theItem: xThing)
        movedown(item: o, theItem: oThing)
        movedown(item: xTwo, theItem: xTwoThing)
        movedown(item: oTwo, theItem: oTwoThing)
        movedown(item: xThree, theItem: xThreeThing)
        movedown(item: oThree, theItem: oThreeThing)

    }
}
