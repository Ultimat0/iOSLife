//
//  ColonyDetailController.swift
//  iOSLife
//
//  Created by Lev Lvovsky on 12/2/18.
//  Copyright © 2018 King Ultimat0's Fabulous Creations. All rights reserved.
//

import UIKit

class ColonyDetailController: UIViewController, UITextFieldDelegate {
    
    var colony: ColonyItem!
    
    @IBOutlet var name: UITextField!
    @IBOutlet var wrapping: UISwitch!
    @IBOutlet var basicTemp: UISwitch!
    @IBOutlet var gliderTemp: UISwitch!
    
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        name.text = colony.name
        wrapping.setOn(colony.colony.wrapping, animated: animated)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        colony.name = name.text
        colony.wrapping = wrapping.isOn
        colony.colony.wrapping = wrapping.isOn
        if basicTemp.isOn {colony.colony.setBasic()}
        if gliderTemp.isOn {colony.colony.setGlider()}
    }
}
