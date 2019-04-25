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
        
        buttons = makeButtonArray()
        smallBoardDraw(board: board)
        
        print(buttons)
    }

    func bigBoardDraw()
    {
        
    }
    
    func smallBoardDraw(board: Board)
    {
        //For each button in buttons or each button in grid, add the buttons to the subview
        for buttonArray in buttons
        {
            for button in buttonArray
            {
                self.view.addSubview(button)
                
            }

        }
        
        //MOVED TO MAKE BUTTON ARRAY
//        var buttonLength = 50
//        var col = 0
//        var row = 0
//        var x = 0
//        var y = 0
//        while(row < board.grid.count)
//        {
//            while(col < board.grid[row].count)
//            {
//                let button = UIButton(frame: CGRect(x: x, y: y, width: buttonLength, height: buttonLength))
//                button.backgroundColor = .green
//                button.setTitle(board.grid[row][col], for: .normal)
//                button.setTitleColor(.black, for: .normal)
//                button.addTarget(self, action: #selector(buttonTest), for: .touchUpInside)
//                self.view.addSubview(button)
//
//                x += buttonLength + 1
//                col += 1
//            }
//            x = 0
//            y += buttonLength + 1
//            col = 0
//            row += 1
//        }
    }
    
    func makeButtonArray() -> [[UIButton]]
    {
        var buttons = [[UIButton]]()
        let buttonLength = 50
        var col = 0
        var row = 0
        var x = 0
        var y = 0
        while(row < board.grid.count)
        {
            var buttonRow = [UIButton]()
            while(col < board.grid[row].count)
            {
                let button = UIButton(frame: CGRect(x: x, y: y, width: buttonLength, height: buttonLength))
                button.backgroundColor = .green
                button.setTitle(board.grid[row][col], for: .normal)
                button.setTitleColor(.black, for: .normal)
                button.addTarget(self, action: #selector(buttonTest), for: .touchUpInside)
                buttonRow.append(button)
    
                x += buttonLength + 1
                col += 1
            }
            buttons.append(buttonRow)
            x = 0
            y += buttonLength + 1
            col = 0
            row += 1
        }
        return buttons
    }
    
    @IBAction func buttonTest(_ sender: UIButton)
    {
        sender.backgroundColor = .red
        sender.setTitle(currentPlayer, for: .normal)
        
        if(currentPlayer == "X")
        {
            currentPlayer = "O"
        }
        else
        {
            currentPlayer = "X"
        }
        
        var pos: CGPoint = findButton(sender)
        print("button tapped \(pos)")
    }
    
    func findButton(_ sender: UIButton) -> CGPoint {
        for var y in 0...2 {
            for var x in 0...2 {
                if (buttons[y][x] == sender) {
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
