//
//  BigBoard.swift
//  UltimateTicTacToe
//
//  Created by Le, Brandon M on 4/23/19.
//  Copyright © 2019 friscoisd. All rights reserved.
//

import SpriteKit
import Foundation

class BigBoard
{
    var grid: [[Board]]
    var winner: String
    
    var isFull: Bool
    var numBoardsFull: Int = 0
    
    var selectedBoard: CGPoint
    
    init()
    {
        grid = [[Board(),Board(),Board()],[Board(),Board(),Board()],[Board(),Board(),Board()]]
        winner = " "
        
        isFull = false
        
        selectedBoard = CGPoint(x: 0, y: 0)
    }
    
    func play(_ player: String, at pos: CGPoint) {
        var x = Int(pos.x)
        var y = Int(pos.y)
        
        guard x >= 0 && x < 9 && y >= 0 && y < 9 else { return; }
        
        let boardX = x % 3
        let boardY = y % 3
        x = x / 3
        y = y / 3
        
        guard grid[y][x].grid[boardY][boardX] == " " else { return }
        
        grid[y][x].play(player, at: CGPoint(x: boardX, y: boardY))
        
        // check for winner
        var col = 0;
        while (col < 3) {
            if (grid[col][x].winner != player) {
                break
            }
            col += 1
            
            if (col == 3) {
                setWinner(to: player)
            }
        }
        
        var row = 0;
        while (row < 3) {
            if (grid[y][row].winner != player) {
                break
            }
            row += 1
            
            if (row == 3) {
                setWinner(to: player)
            }
        }
        
        if (y == x) {
            row = 0;
            while (row < 3) {
                if (grid[row][row].winner != player) {
                    break
                }
                row += 1
                
                if (row == 3) {
                    setWinner(to: player)
                }
            }
        }
        
        if (y == 2 - x) {
            row = 0;
            while (row < 3) {
                if (grid[row][2 - row].winner != player) {
                    break
                }
                row += 1
                
                if (row == 3) {
                    setWinner(to: player)
                }
            }
        }
        
        
        if (grid[y][x].isFull) {
            numBoardsFull += 1
            if (numBoardsFull == 9) {
                isFull = true
            }
        }
        
        
        // set selected board
        if (grid[boardY][boardX].isFull) {
            selectedBoard = CGPoint(x: -1, y: -1)
        }
        else {
            selectedBoard = CGPoint(x: boardX, y: boardY)
        }
        
    }
    
    func setWinner(to player: String) {
        winner = player
    }
    
}
