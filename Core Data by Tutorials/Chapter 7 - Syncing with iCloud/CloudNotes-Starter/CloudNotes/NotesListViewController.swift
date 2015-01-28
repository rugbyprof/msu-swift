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

//@objc (NotesListViewController)
class NotesListViewController: UITableViewController, NSFetchedResultsControllerDelegate {
  lazy var stack : CoreDataStack = {
    let manager = DataMigrationManager(
      storeNamed:"CloudNotes",
      modelNamed:"CloudNotesDataModel")
    return manager.stack
    }()

  var _notes : NSFetchedResultsController? = nil
  var notes : NSFetchedResultsController {
    if _notes == nil {
      let request = NSFetchRequest(entityName: "Note")
      request.sortDescriptors = [NSSortDescriptor(key: "dateCreated", ascending: false)]
    
      let notes = NSFetchedResultsController(fetchRequest: request, managedObjectContext: stack.context, sectionNameKeyPath: nil, cacheName: nil)
      notes.delegate = self
      _notes = notes
    }
    return _notes!
  }
  
  override func viewWillAppear(animated: Bool){
    super.viewWillAppear(animated)
    notes.performFetch(nil)
    tableView.reloadData()
  }
  
  override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    var objects = notes.fetchedObjects
    if let objects = objects
    {
        return objects.count
    }
    return 0
  }
  
  override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let note = notes.fetchedObjects![indexPath.row] as Note
    var identifier = "NoteCell"
    if note.image != nil {
      identifier = "NoteCellImage"
    }
    var cell = tableView.dequeueReusableCellWithIdentifier(identifier, forIndexPath: indexPath) as NoteTableViewCell;
    cell.note = notes.fetchedObjects![indexPath.row] as? Note
    return cell
  }
  
  func controllerWillChangeContent(controller: NSFetchedResultsController) {
    
  }
  
  func controller(controller: NSFetchedResultsController!, didChangeObject anObject: AnyObject!, atIndexPath indexPath: NSIndexPath!, forChangeType type: NSFetchedResultsChangeType, newIndexPath: NSIndexPath!) {
    switch type
      {
    case .Insert:
      tableView.insertRowsAtIndexPaths([newIndexPath], withRowAnimation: .Automatic)
    case .Delete:
      tableView.deleteRowsAtIndexPaths([indexPath], withRowAnimation: .Automatic)
    default:
      break
    }
  }
  
  func controllerDidChangeContent(controller: NSFetchedResultsController!) {
    
  }
  
  @IBAction
  func unwindToNotesList(segue:UIStoryboardSegue) {
    NSLog("Unwinding to Notes List")
    var error : NSErrorPointer = nil
    if stack.context.hasChanges
    {
      if stack.context.save(error) == false
      {
        print("Error saving \(error)")
      }
    }
  }
  
  override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
    if segue.identifier == "createNote"
    {
      let context = NSManagedObjectContext(concurrencyType: .ConfinementConcurrencyType)
      context.parentContext = stack.context
      let navController = segue.destinationViewController as UINavigationController
      let nextViewController = navController.topViewController as CreateNoteViewController
      nextViewController.managedObjectContext = context
    }
    if segue.identifier == "showNoteDetail" || segue.identifier == "showNoteImageDetail" {
      let detailView = segue.destinationViewController as NoteDetailViewController
        if let selectedIndex = tableView.indexPathForSelectedRow() {
          if let objects = notes.fetchedObjects {
            detailView.note = objects[selectedIndex.row] as? Note
          }
      }
    }
  }
}
