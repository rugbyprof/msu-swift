//
//  DetailViewController.swift
//  Griffin01
//
//  Created by Shawn Seals on 1/26/15.
//  Copyright (c) 2015 Shawn Seals. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    // MARK: - Properties

    @IBOutlet weak var trackNameLabel: UILabel!

    var itunesItem: ItunesItem!
    
    // MARK: - View Lifecycle

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        self.configureView()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func configureView() {
        // Update the user interface for the detail item.
        if let detailItunesItem = itunesItem {
            trackNameLabel.text = detailItunesItem.trackName
        } else {
            trackNameLabel.text = ""
        }
    }

}

