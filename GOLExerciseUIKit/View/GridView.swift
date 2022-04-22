//
//  GridView.swift
//  GOLExerciseUIKit
//
//  Created by ThomasWDev on 4/21/22.
//

import UIKit

public class GridView: UIView {
    
    public var board: Board!
    ///The cellSize is what we’ll use to draw each cell on canvas
    private var cellSize: CGFloat = 0.0
    
    public convenience init() {
        let frame = CGRect(x: 0, y: 0, width: 1000, height: 1000)
        self.init(frame: frame)
    }
    
    public convenience init(gridSize: Int64, cellSize: CGFloat) {
        let frame = CGRect(x: 0.0, y: 0.0, width: CGFloat(gridSize) * cellSize, height: CGFloat(gridSize) * cellSize)
        self.init(frame: frame)
        self.board = Board()
        self.board.matricsSize = gridSize
        self.cellSize = cellSize
    }
    
    public override func draw(_ rect: CGRect) {
        let context = UIGraphicsGetCurrentContext()
        context?.saveGState()
        board.allCells.forEach { cell in
            let rect = CGRect(x: CGFloat(cell.x) * cellSize, y: CGFloat(cell.y) * cellSize, width: cellSize, height: cellSize)
            let color = board.alive.contains(cell) ? UIColor.blue.cgColor : UIColor.gray.cgColor
            context?.addRect(rect)
            context?.setFillColor(color)
            context?.fill(rect)
        }
        context?.restoreGState()
    }
    
    
    
    public func updateNextGenerationByRules() {
        board.makeBoard()
        //board.step()
        self.setNeedsDisplay()
    }
    
}
