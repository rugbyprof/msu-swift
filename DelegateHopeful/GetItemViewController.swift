//
//  GetItemViewController.swift
//  DelegateHopeful
//
//  Created by Terry Griffin on 3/9/15.
//  Copyright (c) 2015 Terry Griffin. All rights reserved.
//

import UIKit

// set up the setDateValueDelegate protocol with the set date function
protocol setTextValueDelegate {
    func text(value: String)
}

class GetItemViewController : UIViewController {
    
var delegate: setTextValueDelegate?
    
    
}