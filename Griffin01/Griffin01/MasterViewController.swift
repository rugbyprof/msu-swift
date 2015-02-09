//
//  MasterViewController.swift
//  Griffin01
//
//  Created by Shawn Seals on 1/26/15.
//  Copyright (c) 2015 Shawn Seals. All rights reserved.
//

import UIKit

class MasterViewController: UITableViewController, UISearchBarDelegate {
    
    
    // MARK: - Properties

    var detailViewController: DetailViewController? = nil
    var itunesItems = [ItunesItem]()

    @IBOutlet weak var searchBar: UISearchBar!

    // MARK: - View Lifecycle
    
    override func awakeFromNib() {
        super.awakeFromNib()
        if UIDevice.currentDevice().userInterfaceIdiom == .Pad {
            self.clearsSelectionOnViewWillAppear = false
            self.preferredContentSize = CGSize(width: 320.0, height: 600.0)
        }
    }

    override func viewDidLoad() {
        
        super.viewDidLoad()
        
        // Do any additional setup after loading the view, typically from a nib.
    
        if let split = self.splitViewController {
            let controllers = split.viewControllers
            self.detailViewController = controllers[controllers.count-1].topViewController as? DetailViewController
        }
        
        searchBar.delegate = self
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: - UISearchBarDelegate
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        
        itunesItems.removeAll(keepCapacity: false)
        tableView.reloadData()
        
        let searchTerm = searchBar.text
        WebServicesManager.sharedInstance.downloadItunesItemsMatchingSearchTerm(searchTerm, withCompletion: { (itunesItems, success) -> Void in
            self.itunesItems = itunesItems
            dispatch_async(dispatch_get_main_queue(), { () -> Void in
                self.tableView.reloadData()
            })
        })
        searchBar.resignFirstResponder()
    }
    

    // MARK: - Segues

    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        if segue.identifier == "showDetail" {
            if let indexPath = self.tableView.indexPathForSelectedRow() {
                let controller = (segue.destinationViewController as UINavigationController).topViewController as DetailViewController
                controller.itunesItem = itunesItems[indexPath.row]
                controller.navigationItem.leftBarButtonItem = self.splitViewController?.displayModeButtonItem()
                controller.navigationItem.leftItemsSupplementBackButton = true
            }
        }
    }

    // MARK: - Table View

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return itunesItems.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCellWithIdentifier("Cell", forIndexPath: indexPath) as UITableViewCell

        let titleLabel = cell.viewWithTag(101) as UILabel
        let itunesItem = itunesItems[indexPath.row]
        titleLabel.text = itunesItem.trackName
        
        let imageView = cell.viewWithTag(102) as UIImageView
        let placeholderImage = UIImage(named: "GreyPlaceholder")
        imageView.image = placeholderImage
        
        WebServicesManager.sharedInstance.downloadImageFromUrl(itunesItem.imageUrlString) { (image, success) -> Void in
            if let unwrappedImage = image {
                dispatch_async(dispatch_get_main_queue(), { () -> Void in
                    imageView.image = unwrappedImage
                })
            }
        }
        return cell
    }

    override func tableView(tableView: UITableView, canEditRowAtIndexPath indexPath: NSIndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return false
    }


}

