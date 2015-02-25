//
//  ViewController.swift
//  Checklists2
//
//  Created by Terry Griffin on 2/25/15.
//  Copyright (c) 2015 mwsu. All rights reserved.
//

import UIKit

class ChecklistViewController: UITableViewController {
    
    var row0text = "Walk the dog"
    var row1text = "Brush teeth"
    var row2text = "Learn iOS development"
    var row3text = "Soccer practice"
    var row4text = "Eat ice cream"
    
    var row0checked = false
    var row1checked = true
    var row2checked = false
    var row3checked = true
    var row4checked = false

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 44
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 5
    }
    
    
    override func tableView(tableView: UITableView,cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("ChecklistItem")as UITableViewCell
        
        
        let label = cell.viewWithTag(1000) as UILabel

        if indexPath.row == 0 {
            row0text = "Walk the dog"
        } else if indexPath.row == 1 {
            row0text = "Brush my teeth"
        } else if indexPath.row == 2 {
            row0text = "Learn iOS development"
        } else if indexPath.row == 3 {
            row0text = "Soccer practice"
        } else if indexPath.row == 4 {
            row0text = "Eat ice cream"
        }
        
        configureCheckmarkForCell(cell, indexPath: indexPath)
        
        return cell
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
            
            
        if let cell = tableView.cellForRowAtIndexPath(indexPath) {
        
            if indexPath.row == 0 {
                row0checked = !row0checked
            } else if indexPath.row == 1 {
                row1checked = !row1checked
            } else if indexPath.row == 2 {
                row2checked = !row2checked
            } else if indexPath.row == 3 {
                row3checked = !row3checked
            } else if indexPath.row == 4 {
                row4checked = !row4checked
            }
        
            configureCheckmarkForCell(cell, indexPath: indexPath)
        
        }
        
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
    }
    
    func configureCheckmarkForCell(cell: UITableViewCell, indexPath: NSIndexPath) {
        var isChecked = false
        if indexPath.row == 0 {
            isChecked = row0checked
        } else if indexPath.row == 1 {
            isChecked = row1checked
        } else if indexPath.row == 2 {
            isChecked = row2checked
        } else if indexPath.row == 3 {
            isChecked = row3checked
        } else if indexPath.row == 4 {
            isChecked = row4checked
        }
            
        if isChecked {
            cell.accessoryType = .Checkmark
        } else {
            cell.accessoryType = .None
        }
    }

}

