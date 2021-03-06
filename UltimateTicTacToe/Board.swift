//
//  Board.swift
//  UltimateTicTacToe
//
//  Created by Zhang, Matthew on 4/17/19.
//  Copyright © 2019 friscoisd. All rights reserved.
//

import SpriteKit
import Foundation

class Board
{
    var grid: [[String]]
    var winner: String
    
    var numTimesPlayed: Int
    var isFull: Bool { return numTimesPlayed >= 9 }
    
    init()
    {
        grid = [[" "," "," "],[" "," "," "],[" "," "," "]]
        winner = " "
        
        numTimesPlayed = 0
    }
    
    func play(_ player: String, at pos: CGPoint) -> Bool
    {
        let x = Int(pos.x)
        let y = Int(pos.y)
        
        guard x >= 0 && x < 3 && y >= 0 && y < 3 else { return false }
        guard grid[y][x] == " " else { return false }
        
        grid[y][x] = player
        
        // check for winner
        for col in 0...2 {
            if grid[col][x] != player {
                break
            }
            if col == 2 {
                setWinner(to: player)
            }
        }
        
        for row in 0...2 {
            if grid[y][row] != player {
                break
            }
            if row == 2 {
                setWinner(to: player)
            }
        }
        
        if y == x {
            for row in 0...2 {
                if grid[row][row] != player {
                    break
                }
                if row == 2 {
                    setWinner(to: player)
                }
            }
        }
        
        if y == 2 - x {
            for row in 0...2 {
                if grid[row][2 - row] != player {
                    break
                }
                if row == 2 {
                    setWinner(to: player)
                }
            }
        }
        
        
        numTimesPlayed += 1
        
        return true
    }
    
    func setWinner(to player: String) {
        winner = player
    }
    
}
