//
//  ColonyItem.swift
//  iOSLife
//
//  Created by Masha Chausovsky on 11/23/18.
//  Copyright © 2018 King Ultimat0's Fabulous Creations. All rights reserved.
//

import Foundation

class ColonyItem: NSObject {
    
    
    var name: String?
    var id: Int
    var dateCreated: String
    var colony: Colony = Colony()
    var wrapping: Bool = false
    var glider: Bool = false
    var basic: Bool = false
    
    init (name: String?, id: Int, dateCreated: String) {
        self.dateCreated = dateCreated
        self.name = name
        self.id = id
    }
}
