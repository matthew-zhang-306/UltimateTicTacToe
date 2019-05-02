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
    var winnerViews: [[UIImageView]]!
    
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
        }
        
        screenWidth = Int(screenSize.width)
        screenHeight = Int(screenSize.height)
        
        buttons = makeButtonArray()
        winnerViews = createWinnerViews()
        smallBoardDraw(buttons: buttons)
        enableInitialBoard()
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
        let startingY = (screenHeight/2) - (buttonLength*5) + (buttonLength/2)
        
        for var row in 0...8
        {
            var buttonRow = [UIButton]()
            for var col in 0...8
            {
                let button = UIButton(frame: CGRect(x: col * buttonLength + padding, y: startingY + (row * buttonLength + padding), width: buttonLength - 2 * padding, height: buttonLength - 2 * padding))
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
    
    //Creates 3x3 imageviews that will go on top of each subboard
    func createWinnerViews() -> [[UIImageView]]
    {
        let viewLength = screenWidth / 3
        let startingY = (screenHeight/2) - (viewLength*2) + (viewLength/2)
        var imageViews = [[UIImageView]]()
        
        var imageViewRow = [UIImageView]()
        for var row in 0...2
        {
                for var col in 0...2
                {
                    let view = UIImageView(frame: CGRect(x: col * viewLength, y: startingY + (row * viewLength), width: viewLength, height: viewLength))
                    self.view.addSubview(view)
                    imageViewRow.append(view)
                }
            imageViews.append(imageViewRow)
            imageViewRow = [UIImageView]()
        }
        
        return imageViews
    }
    
    
    @IBAction func buttonTest(_ sender: UIButton)
    {
        var pos: CGPoint = findButton(sender)
        
        guard bigBoard.play(currentPlayer, at: pos) else { return }
        guard let previousPlayBoardPosition = bigBoard.previousPlayBoardPosition else { return }
        guard let previousPlayCellPosition = bigBoard.previousPlayCellPosition else { return }
        let boardX = Int(previousPlayBoardPosition.x)
        let boardY = Int(previousPlayBoardPosition.y)
        let cellX = Int(previousPlayCellPosition.x)
        let cellY = Int(previousPlayCellPosition.y)
        
        // Set button state
        sender.setImage(UIImage(named: "\(currentPlayer)"), for: .normal)
        
        if(bigBoard.grid[boardY][boardX].winner == currentPlayer)
        {
            winnerViews[boardY][boardX].image = UIImage(named: "\(currentPlayer)")
            self.view.bringSubview(toFront: winnerViews[boardY][boardX])
        }
        
        // Set activation of buttons
        for var row in 0...8 {
            for var col in 0...8 {
                if cellX == col / 3 && cellY == row / 3
                {
                    buttons[row][col].isEnabled = true
                    updateColorOfButton(buttons[row][col])
                }
                else {
                    buttons[row][col].isEnabled = bigBoard.grid[cellY][cellX].isFull || bigBoard.grid[cellY][cellX].winner != " "
                    updateColorOfButton(buttons[row][col])
                }
            }
        }
        
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
    
    func enableInitialBoard()
    {
        for var row in 0...8
        {
            for var col in 0...8
            {
                if col > 2 || row > 2
                {
                    buttons[row][col].isEnabled = false
                    updateColorOfButton(buttons[row][col])
                }
            }
        }
    }
    
    func updateColorOfButton(_ button: UIButton) {
        guard let color = button.backgroundColor else { return }
        button.backgroundColor = color.withAlphaComponent(button.isEnabled ? 1 : 0.5)
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
