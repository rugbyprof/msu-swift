/*
* Copyright (c) 2014 Razeware LLC
*
* Permission is hereby granted, free of charge, to any person obtaining a copy
* of this software and associated documentation files (the "Software"), to deal
* in the Software without restriction, including without limitation the rights
* to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
* copies of the Software, and to permit persons to whom the Software is
* furnished to do so, subject to the following conditions:
*
* The above copyright notice and this permission notice shall be included in
* all copies or substantial portions of the Software.
*
* THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
* IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
* FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
* AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
* LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
* OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
* THE SOFTWARE.
*/

import UIKit
import CoreData

class ViewController: UIViewController, UITableViewDataSource {
  
  @IBOutlet var tableView: UITableView!
  var currentDog: Dog!
  var managedContext: NSManagedObjectContext!
  
  override func viewDidLoad() {
    super.viewDidLoad()
    // Do any additional setup after loading the view, typically from a nib.
    
    tableView.registerClass(UITableViewCell.self,
      forCellReuseIdentifier: "Cell")
    
    //Insert Dog entity
    
    let dogEntity = NSEntityDescription.entityForName("Dog",
      inManagedObjectContext: managedContext)
    
    let dog = Dog(entity: dogEntity!,
      insertIntoManagedObjectContext: managedContext)
    
    let dogName = "Fido"
    let dogFetch = NSFetchRequest(entityName: "Dog")
    dogFetch.predicate = NSPredicate(format: "name == %@", dogName)
    
    var error: NSError?
    
    let result =
    managedContext.executeFetchRequest(dogFetch,
      error: &error) as [Dog]?
    
    if let dogs = result {
      
      if dogs.count == 0 {
        
        currentDog = Dog(entity: dogEntity!,
          insertIntoManagedObjectContext: managedContext)
        currentDog.name = dogName
        
        if !managedContext.save(&error) {
          println("Could not save: \(error)")
        }
      } else {
        currentDog = dogs[0]
      }
      
    } else {
      println("Could not fetch: \(error)")
    }
  }
  
  func tableView(tableView: UITableView,
    numberOfRowsInSection section: Int) -> Int {
      
      var numRows = 0
      
      if let dog = currentDog? {
        numRows =  dog.walks.count
      }
      
      return numRows;
  }
  
  func tableView(tableView: UITableView,
    titleForHeaderInSection section: Int) -> String? {
      return "List of Walks";
  }
  
  func tableView(tableView: UITableView,
    canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
      return true
  }
  
  
  func tableView(tableView: UITableView,
    commitEditingStyle
    editingStyle: UITableViewCellEditingStyle,
    forRowAtIndexPath indexPath: NSIndexPath) {
      
      if editingStyle == UITableViewCellEditingStyle.Delete {
        
        //1
        let walkToRemove =
        currentDog.walks[indexPath.row] as Walk
        
        //2
        managedContext.deleteObject(walkToRemove)
        
        //3
        var error: NSError?
        if !managedContext.save(&error) {
          println("Could not save: \(error)")
        }
        
        //4
        tableView.deleteRowsAtIndexPaths([indexPath],
          withRowAnimation: UITableViewRowAnimation.Automatic)
      }
  }
  
  func tableView(tableView: UITableView,
    cellForRowAtIndexPath
    indexPath: NSIndexPath) -> UITableViewCell {
      
      let cell =
      tableView.dequeueReusableCellWithIdentifier("Cell",
        forIndexPath: indexPath) as UITableViewCell
      
      let dateFormatter = NSDateFormatter()
      dateFormatter.dateStyle = .ShortStyle
      dateFormatter.timeStyle = .MediumStyle
      
      //the next two statements have changed
      let walk = currentDog.walks[indexPath.row] as Walk
      
      cell.textLabel.text =
        dateFormatter.stringFromDate(walk.date)
      
      return cell
  }
  
  @IBAction func add(sender: AnyObject) {
    
    //Insert new Walk entity into Core Data
    let walkEntity = NSEntityDescription.entityForName("Walk",
      inManagedObjectContext: managedContext)
    
    let walk = Walk(entity: walkEntity!,
      insertIntoManagedObjectContext: managedContext)
    
    walk.date = NSDate()
    
    //Insert the new Walk into the Dog's walks set
    var walks =
    currentDog.walks.mutableCopy() as NSMutableOrderedSet
    
    walks.addObject(walk)
    
    currentDog.walks = walks.copy() as NSOrderedSet
    
    //Save the managed object context
    var error: NSError?
    if !managedContext!.save(&error) {
      println("Could not save: \(error)")
    }
    
    //Reload table view
    tableView.reloadData()
  }
  
}

