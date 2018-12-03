//
//  ColonyView.swift
//  iOSLife
//
//  Created by Lev Lvovsky on 12/3/18.
//  Copyright © 2018 King Ultimat0's Fabulous Creations. All rights reserved.
//

import UIKit

class ColonyView: UIView {
    
    var colonyItem: ColonyItem?
    var color = UIColor.blue
    var controller: ColonyViewController! = nil
    
    var cellSize: CGFloat {
        return frame.height/CGFloat(59)
    }
    
    func drawCell (_ x: Int, _ y: Int) {
        let square = CGRect(x: CGFloat(x) * cellSize, y: CGFloat(y) * cellSize,
                            width: cellSize, height: cellSize).insetBy(dx: cellSize / 10, dy: cellSize / 10)
        let path = UIBezierPath(rect: square)
        color.setFill()
        path.fill()
    }
    
    override func draw(_ rect: CGRect) {
        if let cItem = colonyItem {
            for cell in cItem.colony.cells {
                if cell.x < 60 {
                    drawCell(cell.x, cell.y)
                }
            }
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        let point: CGPoint = touches.first!.preciseLocation(in: self)
        controller.firstTouch(Int(floorf(Float(point.x/cellSize))), Int(floorf(Float(point.y/cellSize))))
        setNeedsDisplay()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        let point: CGPoint = touches.first!.preciseLocation(in: self)
        controller.touchMoved(Int(floorf(Float(point.x/cellSize))), Int(floorf(Float(point.y/cellSize))))
        setNeedsDisplay()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        controller.touchEnded()
        setNeedsDisplay()
    }
}
