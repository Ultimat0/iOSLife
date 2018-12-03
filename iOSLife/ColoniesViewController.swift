//
//  ColoniesViewController.swift
//  iOSLife
//
//  Created by Masha Chausovsky on 11/23/18.
//  Copyright © 2018 King Ultimat0's Fabulous Creations. All rights reserved.
//

import Foundation
import UIKit

class ColoniesViewController: UITableViewController {
    
    var numberFormatter: NumberFormatter {
        let nf = NumberFormatter()
        nf.formatWidth = 4
        nf.minimumIntegerDigits = 4
        nf.maximumIntegerDigits = 4
        nf.allowsFloats = false
        return nf
    }
    
    var dateFormatter: DateFormatter {
        let df = DateFormatter()
        df.dateFormat = "MMM d, YYYY 'at' hh:mm:ss at"
        return df
    }
    
    var colonyController: ColonyViewController! = nil
    
    var colonyStore: ColonyStore = ColonyStore()
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return colonyStore.colonies.count
    }
    
    override func tableView(_ tableView: UITableView,
                            cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "ColonyItemCell", for: indexPath) as! ColonyItemCell
        
        let colonyItem = colonyStore.colonies[indexPath.row]
        cell.nameLabel.text = colonyItem.name ?? "bob"
        
        
        
       // cell.textLabel?.text = "colony"
        //cell.detailTextLabel?.text = log.date
        
        print ("rght \(colonyStore.colonies[indexPath.row])")
        
        return cell
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        navigationItem.leftBarButtonItem = editButtonItem
    }
    
    func addNewItem() -> ColonyItem{
        let cItem = colonyStore.createColonyItem(dateFormatter: dateFormatter, name: nil)
        
        if let index = colonyStore.colonies.index(of: cItem) {
            let indexPath = IndexPath(row: index, section: 0)
            
            tableView.insertRows(at: [indexPath], with: .automatic)
        }
        
        return cItem
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        colonyController.reload()
    }
    
    
  /*  @IBAction func toggleEditingMode(_ sender: UIButton) {
        if isEditing {
            sender.setTitle("Edit", for: .normal)
            
            setEditing(false, animated: true)
        }
        else {
            sender.setTitle("Done", for: .normal)
            
            setEditing(true, animated: true)
        }
    }*/
    
    override func tableView(_ tableView: UITableView,
                            commit editingStyle: UITableViewCell.EditingStyle,
                            forRowAt indexPath: IndexPath) {
        
        if editingStyle == .delete {
            let log = colonyStore.colonies[indexPath.row]
            
            colonyStore.removeColonyItem(log)
            
            tableView.deleteRows(at: [indexPath], with: .automatic)
        }
    }
    
    override func tableView(_ tableView: UITableView,
                            moveRowAt sourceIndexPath: IndexPath,
                            to destinationIndexPath: IndexPath) {
        
        colonyStore.moveColonyItem(from: sourceIndexPath.row, to: destinationIndexPath.row)
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // If the triggered segue is the "showItem" segue
        print("prepareCalled")
        switch segue.identifier {
        case "editColony"?:
            print("preparing")
            // Figure out which row was just tapped
            if let row = tableView.indexPathForSelectedRow?.row {
                // Get the item associated with this row and pass it along
                let colony = colonyStore.colonies[row]
                let detailViewController
                    = segue.destination as! ColonyDetailController
                detailViewController.colony = colony
                colonyController.reload(colony: colony)
            }
        case "addColony"?:
            let cItem = addNewItem()
            let cItemDetailController = segue.destination as! ColonyDetailController
            cItemDetailController.colony = cItem
            colonyController.reload(colony: cItem)
        default:
            preconditionFailure("Unexpected segue identifier.")
        }
    }
}

