//
//  PointHelper.swift
//  UltimateTicTacToe
//
//  Created by Zhang, Matthew on 5/2/19.
//  Copyright © 2019 friscoisd. All rights reserved.
//

import Foundation
import SpriteKit

func +(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
}
func -(lhs: CGPoint, rhs: CGPoint) -> CGPoint {
    return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
}
