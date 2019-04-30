//
//  GameViewController.swift
//  UltimateTicTacToe
//
//  Created by Zhang, Matthew on 4/17/19.
//  Copyright © 2019 friscoisd. All rights reserved.
//

import UIKit
import SpriteKit
import GameplayKit


class GameViewController: UIViewController
{
    var board = Board()
    var bigBoard = BigBoard()
    
    
    let screenSize: CGRect = UIScreen.main.bounds
    var screenWidth: Int!
    var screenHeight: Int!
    var buttons: [[UIButton]]!
    
    
    var currentPlayer = "X"
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if let view = self.view as! SKView?
        {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene")
            {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFill
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
            
            view.showsFPS = true
            view.showsNodeCount = true
        }
        
        screenWidth = Int(screenSize.width)
        
        buttons = makeButtonArray()
        smallBoardDraw(buttons: buttons)
        print(buttons)
    }

    func bigBoardDraw()
    {
        
    }
    
    func smallBoardDraw(buttons: [[UIButton]])
    {
        //For each button in buttons or each button in grid, add the buttons to the subview
        for buttonArray in buttons
        {
            for button in buttonArray
            {
                self.view.addSubview(button)
            }

        }
    }
    
    //Makes 9x9 button array
    func makeButtonArray() -> [[UIButton]]
    {
        var buttons = [[UIButton]]()
        let buttonLength = screenWidth / 9
        let padding = 2
        
        for var row in 0...8
        {
            var buttonRow = [UIButton]()
            for var col in 0...8
            {
                let button = UIButton(frame: CGRect(x: col * buttonLength + padding, y: row * buttonLength + padding, width: buttonLength - 2 * padding, height: buttonLength - 2 * padding))
                button.backgroundColor = .green
                button.setTitle(" ", for: .normal)
                button.setTitleColor(.black, for: .normal)
                button.addTarget(self, action: #selector(buttonTest), for: .touchUpInside)
                buttonRow.append(button)
            }
            buttons.append(buttonRow)
        }
        return buttons
    }
    
    @IBAction func buttonTest(_ sender: UIButton)
    {
        sender.backgroundColor = .red
        sender.setTitle(currentPlayer, for: .normal)
        
        var pos: CGPoint = findButton(sender)
        print("button tapped \(pos)")
        
        bigBoard.play(currentPlayer, at: pos)
        print(bigBoard.previousPlayBoardPosition)
        print(bigBoard.previousPlayCellPosition)
        
        // Switch players
        if currentPlayer == "X"
        {
            currentPlayer = "O"
        }
        else
        {
            currentPlayer = "X"
        }
    }
    
    func findButton(_ sender: UIButton) -> CGPoint {
        for var y in 0...8 {
            for var x in 0...8 {
                if buttons[y][x] == sender {
                    return CGPoint(x: x, y: y)
                }
            }
        }
        return CGPoint(x: -1, y: -1)
    }
    
    override var shouldAutorotate: Bool
    {
        return true
    }

    override var supportedInterfaceOrientations: UIInterfaceOrientationMask
    {
        if UIDevice.current.userInterfaceIdiom == .phone
        {
            return .allButUpsideDown
        }
        else
        {
            return .all
        }
    }

    override func didReceiveMemoryWarning()
    {
        super.didReceiveMemoryWarning()
        // Release any cached data, images, etc that aren't in use.
    }

    override var prefersStatusBarHidden: Bool
    {
        return true
    }

}
