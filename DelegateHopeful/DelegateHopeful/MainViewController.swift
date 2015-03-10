//
//  ViewController.swift
//  DelegateHopeful
//
//  Created by Terry Griffin on 3/9/15.
//  Copyright (c) 2015 Terry Griffin. All rights reserved.
//

import UIKit

class MainViewController: UIViewController, GetItemViewControllerDelegate {

    @IBOutlet weak var givemetext: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    func getItemViewControllerDidCancel(controller: GetItemViewController) {
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func getItemViewController(controller: GetItemViewController, didFinishAddingItem item: String){
        givemetext.text = item
        dismissViewControllerAnimated(true , completion: nil)
    }

}

