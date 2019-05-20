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
    @IBOutlet weak var timerLabel: UILabel!
    
    var board = Board()
    var bigBoard = BigBoard()
    
    var turnTime = 30
    
    let screenSize: CGRect = UIScreen.main.bounds
    var screenWidth: Int!
    var screenHeight: Int!
    var buttons: [[UIButton]]!
    var winnerViews: [[UIImageView]]!
    
    var buttonLength: Int!
    var startingY: Int!
    
    var currentPlayer = "X"
    
    override func viewDidLoad()
    {
        super.viewDidLoad()
        
        if let view = self.view as! SKView?
        {
            // Load the SKScene from 'GameScene.sks'
            if let scene = SKScene(fileNamed: "GameScene") as? GameScene
            {
                self.screenWidth = Int(screenSize.width)
                self.screenHeight = Int(screenSize.height)
                self.buttonLength = screenWidth / 9
                self.startingY = (screenHeight/2) - (buttonLength*5) + (buttonLength/2)
                
                // Set the scale mode to scale to fit the window
                scene.scaleMode = .aspectFit
                scene.size = view.bounds.size
                scene.scenePointToViewPoint = CGPoint(x: -screenSize.width / 2, y: screenSize.height / 2)
                scene.screenSize = screenSize
                scene.startingY = CGFloat(startingY)
                
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
        setButtonActivation(x: 0, y: 0)
        
        timerLabel.text = String(turnTime)
        Timer.scheduledTimer(withTimeInterval: 1, repeats: true, block: {(Timer) in self.updateTime()})
        
    }
    
    func updateTime()
    {
        turnTime -= 1
        if(turnTime == 0)
        {
            turnTime = 30
            if currentPlayer == "X"
            {
                currentPlayer = "O"
            }
            else
            {
                currentPlayer = "X"
            }
        }
        timerLabel.text = String(turnTime)
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
        let padding = 2
        
        for row in 0...8
        {
            var buttonRow = [UIButton]()
            for col in 0...8
            {
                let button = UIButton(frame: CGRect(x: col * buttonLength + padding, y: startingY + row * buttonLength + padding, width: buttonLength - 2 * padding, height: buttonLength - 2 * padding))
                button.backgroundColor = .white
                button.setTitle(" ", for: .normal)
                button.setTitleColor(.clear, for: .normal)
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
        for row in 0...2
        {
            for col in 0...2
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
        guard bigBoard.winner == " " else { return }
        
        let pos: CGPoint = findButton(sender)
        
        guard bigBoard.play(currentPlayer, at: pos) else { return }
        guard let previousPlayBoardPosition = bigBoard.previousPlayBoardPosition else { return }
        guard let previousPlayCellPosition = bigBoard.previousPlayCellPosition else { return }
        let boardX = Int(previousPlayBoardPosition.x)
        let boardY = Int(previousPlayBoardPosition.y)
        let cellX = Int(previousPlayCellPosition.x)
        let cellY = Int(previousPlayCellPosition.y)
        
        // Set button state
        sender.setImage(UIImage(named: "\(currentPlayer)"), for: .normal)
        sender.setTitle(currentPlayer, for: .normal)
        turnTime = 30
        
        if(bigBoard.grid[boardY][boardX].winner == currentPlayer)
        {
            winnerViews[boardY][boardX].image = UIImage(named: "\(currentPlayer)")
            self.view.bringSubview(toFront: winnerViews[boardY][boardX])
        }
        
        if(bigBoard.winner == currentPlayer)
        {
            performSegue(withIdentifier: "WinScreenSegue", sender: self)
        }
        
        // Set activation of buttons
        setButtonActivation(x: cellX, y: cellY)
        
        // Check for winner
        if bigBoard.winner == currentPlayer {
            let winRect = UIButton(frame: CGRect(x: 0, y: 0, width: screenWidth, height: screenHeight))
            
            winRect.isEnabled = false
            winRect.backgroundColor = UIColor.black.withAlphaComponent(0.5)
            winRect.setTitle("\(currentPlayer) wins!", for: .normal)
            winRect.setTitleColor(.white, for: .normal)
            winRect.titleLabel?.font = .systemFont(ofSize: 60)
            winRect.titleLabel?.textAlignment = .center
            
            self.view.addSubview(winRect)
        }
        else {
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
                if bigBoard.winner != " " {
                    buttons[row][col].isEnabled = false
                }
                else if buttons[row][col].titleLabel?.text != " " {
                    buttons[row][col].isEnabled = false
                }
                else if bigBoard.grid[row / 3][col / 3].winner != " " {
                    buttons[row][col].isEnabled = false
                }
                else if cellX == col / 3 && cellY == row / 3 {
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?)
    {
        if let destination = segue.destination as? WinScreenViewController
        {
            destination.winner = self.bigBoard.winner
        }
    }
    
    func newGame()
    {
        board = Board()
        bigBoard = BigBoard()
        currentPlayer = "X"
        setButtonActivation(x: 0, y: 0)
    }
}
