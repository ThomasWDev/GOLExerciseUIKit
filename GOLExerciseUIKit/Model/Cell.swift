//
//  Cell.swift
//  GOLExerciseUIKit
//
//  Created by ThomasWDev on 4/21/22.
//

public struct Cell: Hashable {
    public var x: Int64
    public var y: Int64
    
    public func neighbors() -> [Cell] {
        var neighbors: [Cell] = []
        
        for xn in x-1...x+1 {
            for yn in y-1...y+1 {
                if (x != xn || y != yn) {
                    neighbors.append(Cell(x: xn, y: yn))
                }
            }
        }
        
        return neighbors
    }
    
    public static func == (lhs: Cell, rhs: Cell) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y
    }

    public func hash(into hasher: inout Hasher) {
        hasher.combine(x)
        hasher.combine(y)
    }
}
