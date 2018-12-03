//
//  Colony.swift
//  Stulin's Game of Life
//
//  Created by Masha Chausovsky on 9/16/18.
//  Copyright © 2018 King Ultimat0's Fabulous Creations. All rights reserved.
//

import Foundation

class Colony: CustomStringConvertible {
    
    var cells = Set<Cell>()
    var generation: Int = 0
    let size: Int = 60
    public var wrapping: Bool = false
    
    func setCellAlive(x: Int, y: Int) {
        cells.insert(Cell(x: x, y: y))
    }
    
    func setCellDead(x: Int, y: Int) {
        cells.remove(Cell(x: x, y: y))
    }
    
    func resetColony() {
        cells = Set<Cell>()
    }
    
    var description: String {
        var map = "Generation #\(generation)\n"
        for y in 0..<size {
            for x in 0..<size {
                map += isCellAlive(x: x, y: y) ? "*" : " "
            }
            map += "\n"
        }
        return map
    }
    
    func isCellAlive (x: Int, y: Int) -> Bool {
        return cells.contains(Cell(x: x, y: y))
    }
    
    func isCellAlive (cell: Cell) -> Bool {
        return cells.contains(cell)
    }
    
    func numSurroundingAlive (x: Int, y: Int) -> Int {
        var numAlive = 0
        for i in -1...1 {
            for j in -1...1 {
                if isCellAlive(cell: wrap(x+j, y+i)) {
                        numAlive += 1
                }
            }
        }
        return isCellAlive(x: x, y: y) ? numAlive - 1 : numAlive
    }
    
    func wrap (_ x: Int, _ y: Int) -> Cell {
        return wrapping ? Cell(x: (x + size) % size, y: (y + size) % size) : Cell(x: x, y: y)
    }
    
    func willBeAlive (x: Int, y: Int) -> Set<Cell> {
        var alives = Set<Cell>()
        for i in -1...1 {
            for j in -1...1 {
                if numSurroundingAlive(x: x+j, y: y+i) == 3 || (isCellAlive(x: x+j, y: y+i) && numSurroundingAlive(x: x+j, y: y+i) == 2) {
                    alives.insert(wrap(x+j, y+i))
                }
            }
        }
        return alives
    }
    
    func evolve () {
        generation += 1
        var temp = Set<Cell>()
        for cell in cells {
            for alive in willBeAlive(x: cell.x, y: cell.y) {
                temp.insert(alive)
            }
        }
        cells = temp
    }
    
    func setBasic () {
        setCellAlive(x: 5, y: 5)
        setCellAlive(x: 5, y: 6)
        setCellAlive(x: 5, y: 7)
    }
    
    func setGlider () {
        setCellAlive(x: 19, y: 30)
        setCellAlive(x: 20, y: 30)
        setCellAlive(x: 21, y: 30)
        setCellAlive(x: 21, y: 29)
        setCellAlive(x: 20, y: 28)
    }
    
}
