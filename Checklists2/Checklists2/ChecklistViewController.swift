//
//  ViewController.swift
//  Checklists2
//
//  Created by Terry Griffin on 2/25/15.
//  Copyright (c) 2015 mwsu. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController {
    
    var items:[ChecklistItem]
    
<<<<<<< HEAD
=======
    var row0checked = false
    var row1checked = true
    var row2checked = false
    var row3checked = true
    var row4checked = false
    
    var items: [ChecklistItem]
    
>>>>>>> aa0c3cc5b36d2a1f8c8e2f982f0ecd191d154972
    required init(coder aDecoder: NSCoder) {
        
        items = [ChecklistItem]()
        
        let row0item = ChecklistItem()
<<<<<<< HEAD
        row0item.text = "Walk the cat"
=======
        row0item.text = "Item 1"
>>>>>>> aa0c3cc5b36d2a1f8c8e2f982f0ecd191d154972
        row0item.checked = false
        items.append(row0item)
        
        let row1item = ChecklistItem()
<<<<<<< HEAD
        row1item.text = "Brush my hair"
        row1item.checked = true
        items.append(row1item)
        
        let row2item = ChecklistItem()
        row2item.text = "Learn javascript development"
        row2item.checked = true
        items.append(row2item)
        
        let row3item = ChecklistItem()
        row3item.text = "Rugby practice"
        row3item.checked = false
        items.append(row3item)
        
        let row4item = ChecklistItem()
        row4item.text = "Eat hair cream"
        row4item.checked = true
        items.append(row4item)
        
        super.init(coder: aDecoder)
=======
        row1item.text = "Item 2"
        row1item.checked = true
        items.append(row1item)
    
        let row2item = ChecklistItem()
        row2item.text = "Item 3"
        row2item.checked = false
        items.append(row2item)
        
        let row3item = ChecklistItem()
        row3item.text = "Item 4"
        row3item.checked = true
        items.append(row3item)
        
        let row4item = ChecklistItem()
        row4item.text = "Item 5"
        row4item.checked = false
        items.append(row4item)

        super.init(coder: aDecoder)
        
>>>>>>> aa0c3cc5b36d2a1f8c8e2f982f0ecd191d154972
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 44
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return items.count
    }
    
    
    override func tableView(tableView: UITableView,cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ChecklistItem")as UITableViewCell
        
        let label = cell.viewWithTag(1000) as UILabel
<<<<<<< HEAD
        
        label.text = items[indexPath.row].text
=======
>>>>>>> aa0c3cc5b36d2a1f8c8e2f982f0ecd191d154972
        
        label.text = items[indexPath.row].text

        configureCheckmarkForCell(cell, indexPath: indexPath)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
            
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
        
            items[indexPath.row].checked = !items[indexPath.row].checked
<<<<<<< HEAD
            
=======
        
>>>>>>> aa0c3cc5b36d2a1f8c8e2f982f0ecd191d154972
            configureCheckmarkForCell(cell, indexPath: indexPath)
        
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func configureCheckmarkForCell(cell: UITableViewCell, indexPath: NSIndexPath) {
<<<<<<< HEAD
            
=======
                    
>>>>>>> aa0c3cc5b36d2a1f8c8e2f982f0ecd191d154972
        if items[indexPath.row].checked {
            cell.accessoryType = .Checkmark
        } else {
            cell.accessoryType = .None
        }
                    
    }

}

