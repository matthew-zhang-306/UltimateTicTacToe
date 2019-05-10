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
            if let scene = SKScene(fileNamed: "GameScene") as? GameScene
            {
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFit
                scene.size = view.bounds.size
                scene.scenePointToViewPoint = CGPoint(x: -screenSize.width / 2, y: screenSize.height / 2)
                scene.screenSize = screenSize
                
                // Present the scene
                view.presentScene(scene)
            }
            
            view.ignoresSiblingOrder = true
        }
        
        screenWidth = Int(screenSize.width)
        
        buttons = makeButtonArray()
        smallBoardDraw(buttons: buttons)
        setButtonActivation(x: 0, y: 0)
        
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
        
        for row in 0...8
        {
            var buttonRow = [UIButton]()
            for col in 0...8
            {
                let button = UIButton(frame: CGRect(x: col * buttonLength + padding, y: row * buttonLength + padding, width: buttonLength - 2 * padding, height: buttonLength - 2 * padding))
                button.backgroundColor = .white
                button.setTitle(" ", for: .normal)
                button.setTitleColor(.white, for: .normal)
                button.addTarget(self, action: #selector(buttonTest), for: .touchUpInside)
                buttonRow.append(button)
            }
            buttons.append(buttonRow)
        }
        return buttons
    }
    
    @IBAction func buttonTest(_ sender: UIButton)
    {
        let pos: CGPoint = findButton(sender)
        
        guard bigBoard.play(currentPlayer, at: pos) else { return }
        guard let previousPlayBoardPosition = bigBoard.previousPlayBoardPosition else { return }
        guard let previousPlayCellPosition = bigBoard.previousPlayCellPosition else { return }
        let _ = Int(previousPlayBoardPosition.x)
        let _ = Int(previousPlayBoardPosition.y)
        let cellX = Int(previousPlayCellPosition.x)
        let cellY = Int(previousPlayCellPosition.y)
        
        // Set button state
        sender.backgroundColor = .red
        sender.setTitle(currentPlayer, for: .normal)
        
        // Set activation of buttons
        setButtonActivation(x: cellX, y: cellY)
        
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
        for y in 0...8 {
            for x in 0...8 {
                if buttons[y][x] == sender {
                    return CGPoint(x: x, y: y)
                }
            }
        }
        return CGPoint(x: -1, y: -1)
    }
    
    func setButtonActivation(x cellX: Int, y cellY: Int)
    {
        for row in 0...8 {
            for col in 0...8 {
                if buttons[row][col].titleLabel?.text != " " {
                    buttons[row][col].isEnabled = false
                }
                else if bigBoard.grid[col / 3][row / 3].winner != " " {
                    buttons[row][col].isEnabled = false
                }
                else if cellX == col / 3 && cellY == row / 3
                {
                    buttons[row][col].isEnabled = true
                }
                else {
                    buttons[row][col].isEnabled = bigBoard.grid[cellY][cellX].isFull || bigBoard.grid[cellY][cellX].winner != " "
                }
                updateColorOfButton(buttons[row][col])
            }
        }
    }
    
    func updateColorOfButton(_ button: UIButton) {
        guard let color = button.backgroundColor else { return }
        button.backgroundColor = color.withAlphaComponent(button.isEnabled ? 0.2 : 0)
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
