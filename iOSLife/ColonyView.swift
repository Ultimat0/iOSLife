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
    var colors: [UIColor] = [UIColor.blue, UIColor.red, UIColor.orange, UIColor.gray, UIColor.purple, UIColor.black, UIColor.green]
    var controller: ColonyViewController! = nil
    
    var cellHeight: CGFloat {
        return frame.height/CGFloat(60)
    }
    
    var cellWidth: CGFloat {
        return frame.width/CGFloat(60)
    }
    
    
    func drawCell (_ x: Int, _ y: Int) {
        let square = CGRect(x: CGFloat(x) * cellWidth, y: CGFloat(y) * cellHeight,
                            width: cellWidth, height: cellHeight).insetBy(dx: cellWidth / 10, dy: cellHeight / 10)
        let path = UIBezierPath(rect: square)
        let color = colors[Int(arc4random()) % colors.count]
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
        guard let c = colonyItem else {return}
        let point: CGPoint = touches.first!.preciseLocation(in: self)
        controller.firstTouch(Int(floorf(Float(point.x/cellWidth))), Int(floorf(Float(point.y/cellHeight))))
        setNeedsDisplay()
    }
    
    override func touchesMoved(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let c = colonyItem else {return}
        let point: CGPoint = touches.first!.preciseLocation(in: self)
        controller.touchMoved(Int(floorf(Float(point.x/cellWidth))), Int(floorf(Float(point.y/cellHeight))))
        setNeedsDisplay()
    }
    
    override func touchesEnded(_ touches: Set<UITouch>, with event: UIEvent?) {
        guard let c = colonyItem else {return}
        controller.touchEnded()
        setNeedsDisplay()
    }
}
