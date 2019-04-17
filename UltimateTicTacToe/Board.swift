//
//  Board.swift
//  UltimateTicTacToe
//
//  Created by Zhang, Matthew on 4/17/19.
//  Copyright © 2019 friscoisd. All rights reserved.
//

import SpriteKit
import Foundation

class Board {
    
    var grid: [[String]]
    var winner: String
    
    init() {
        grid = [[" "," "," "],[" "," "," "],[" "," "," "]]
        winner = " "
    }
    
    func play(_ player: String, at pos: CGPoint) {
        let x = Int(pos.x)
        let y = Int(pos.y)
        
        guard x >= 0 && x < 3 && y >= 0 && y < 3 else { return; }
        
        grid[y][x] = player
        
        // check for winner
        
    }
    
}
