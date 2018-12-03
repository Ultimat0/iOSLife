//
//  ColonyViewController.swift
//  iOSLife
//
//  Created by Lev Lvovsky on 12/3/18.
//  Copyright © 2018 King Ultimat0's Fabulous Creations. All rights reserved.
//

import UIKit

class ColonyViewController: ViewController {
    
    var colonyView: ColonyView! = nil
    var colonyItem: ColonyItem! = nil
    var touchValue: Bool? = nil
    var timer: Timer? = nil
    
    @IBOutlet var speedSlider: UISlider! = nil
    @IBOutlet var onSwitch: UISwitch! = nil

    
    override func viewDidLoad() {
        super.viewDidLoad()
        if timer == nil {createTimer()}
        colonyView = view.subviews.filter{$0.accessibilityIdentifier == "ColonyView"}.first! as! ColonyView
        colonyView.controller = self
        colonyView.setNeedsDisplay()
        print ("viewdidload \(colonyItem)")
    }
    
    func evolve() {
        guard let cItem = colonyView.colonyItem else {return}
        if onSwitch.isOn {colonyView.colonyItem!.colony.evolve()}
        colonyView.setNeedsDisplay()
    }
    
    func createTimer (speed: Double) {
        timer!.invalidate()
        timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(5.0 / speed), repeats: true, block: {_ in self.evolve()})
    }
    
    func createTimer () {
        timer = Timer.scheduledTimer(withTimeInterval: TimeInterval(5.0 / speedSlider.value), repeats: true, block: {_ in self.evolve()})
    }
    
    @IBAction func sliderValueChanged (_ sender: UISlider) {
        createTimer(speed: Double(sender.value))
    }
    
    func reload(colony: ColonyItem) {
        colonyView.colonyItem = colony
        colonyItem = colony
        colonyView.setNeedsDisplay()
    }
    
    func reload() {
        colonyView.setNeedsDisplay()
    }
    
    func firstTouch (_ x: Int, _ y: Int) {
        touchValue = colonyItem.colony.isCellAlive(x: x, y: y)
        touch(x, y)
    }
    
    func touchMoved(_ x: Int, _ y: Int) {
        touch(x, y)
    }
    
    func touchEnded () {touchValue = nil}
    
    func touch (_ x: Int, _ y: Int) {
        guard let same = touchValue else {return}
        if same {
            colonyItem.colony.setCellDead(x: x, y: y)
        } else {
            colonyItem.colony.setCellAlive(x: x, y: y)
        }
    }
}
