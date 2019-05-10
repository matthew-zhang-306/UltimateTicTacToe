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
    
    var numBoardsFull: Int
    var isFull: Bool { return numBoardsFull >= 9 }
    
    var selectedBoard: CGPoint
    
    var previousPlayBoardPosition: CGPoint?
    var previousPlayCellPosition: CGPoint?
    
    init()
    {
        grid = [[Board(),Board(),Board()],[Board(),Board(),Board()],[Board(),Board(),Board()]]
        winner = " "
        
        numBoardsFull = 0
        
        selectedBoard = CGPoint(x: 0, y: 0)
    }
    
    func play(_ player: String, at pos: CGPoint) -> Bool {
        var x = Int(pos.x)
        var y = Int(pos.y)
        
        guard x >= 0 && x < 9 && y >= 0 && y < 9 else { return false }
        
        let boardX = x % 3
        let boardY = y % 3
        x = x / 3
        y = y / 3
        
        guard grid[y][x].grid[boardY][boardX] == " " else { return false }
        
        previousPlayBoardPosition = CGPoint(x: x, y: y)
        previousPlayCellPosition = CGPoint(x: boardX, y: boardY)
        guard grid[y][x].play(player, at: previousPlayCellPosition ?? CGPoint(x: -1, y: -1)) else { return false }
        
        // check for winner
        for col in 0...2 {
            if (grid[col][x].winner != player) {
                break
            }
            if (col == 2) {
                setWinner(to: player)
            }
        }
        
        for row in 0...2 {
            if grid[y][row].winner != player {
                break
            }
            if row == 2 {
                setWinner(to: player)
            }
        }
        
        if y == x {
            for row in 0...2 {
                if grid[row][row].winner != player {
                    break
                }
                if row == 2 {
                    setWinner(to: player)
                }
            }
        }
        
        if y == 2 - x {
            for row in 0...2 {
                if grid[row][2 - row].winner != player {
                    break
                }
                if row == 2 {
                    setWinner(to: player)
                }
            }
        }
        
        
        if grid[y][x].isFull {
            numBoardsFull += 1
        }
        
        
        // set selected board
        if grid[boardY][boardX].isFull {
            selectedBoard = CGPoint(x: -1, y: -1)
        }
        else {
            selectedBoard = CGPoint(x: boardX, y: boardY)
        }
        
        return true
    }
    
    func setWinner(to player: String) {
        winner = player
    }
    
}
