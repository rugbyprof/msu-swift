//
//  GetItemViewController.swift
//  DelegateHopeful
//
//  Created by Terry Griffin on 3/9/15.
//  Copyright (c) 2015 Terry Griffin. All rights reserved.
//

import UIKit

protocol GetItemViewControllerDelegate: class {
    func getItemViewControllerDidCancel(controller: GetItemViewController)
    func getItemViewController(controller: GetItemViewController, didFinishAddingItem item: String)
}

class GetItemViewController : UITableViewController {
    
    @IBOutlet weak var textField: UITextField!
    @IBOutlet weak var doneBarButton: UIBarButtonItem!
    
    weak var delegate: GetItemViewControllerDelegate?
    
    @IBAction func done(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    @IBAction func cancel(sender: AnyObject) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        textField.becomeFirstResponder()
    }
    
    func textField(textField:UITextField, shouldChangeCharactersInRange range: NSRange, replacementString string: String) -> Bool{
        let oldText: NSString = textField.text
        let newText: NSString = oldText.stringByReplacingCharactersInRange(range,withString: string)
        
        doneBarButton.enabled = (newText.length > 0)
        
        println(newText.length)
        
        return true
    }
    
    
}