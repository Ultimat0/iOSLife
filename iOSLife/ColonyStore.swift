//
//  ColonyStore.swift
//  iOSLife
//
//  Created by Masha Chausovsky on 11/23/18.
//  Copyright © 2018 King Ultimat0's Fabulous Creations. All rights reserved.
//

import UIKit

class ColonyStore {
    
    var colonies = [ColonyItem]()
    var currentId = 0
    
    @discardableResult func createColonyItem(dateFormatter: DateFormatter, name: String?) -> ColonyItem {
        let cItem = ColonyItem(name: name, id: currentId, dateCreated: dateFormatter.string(from: Date()))
        colonies.append(cItem)
        
        currentId += 1
        
        return cItem
    }
    
    func removeColonyItem(_ cItem: ColonyItem) {
        if let i = colonies.index(of: cItem) {
            colonies.remove(at: i)
        }
    }
    
    func moveColonyItem(from fromIndex: Int, to toIndex: Int) {
        if fromIndex != toIndex {
            let cItem = colonies[fromIndex]
            
            colonies.remove(at: fromIndex)
            
            colonies.insert(cItem, at: toIndex)
        }
    }
}
