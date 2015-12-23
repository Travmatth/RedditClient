//
//  SubredditTableViewController.swift
//  RedditClient
//
//  Created by Travis Matthews on 11/26/15.
//  Copyright © 2015 Travis Matthews. All rights reserved.
//

import UIKit


class SubredditViewController: UITableViewController, NetworkCommunication {

    var name: String!
    weak var session: Session!
    var linkListing: LinkListing?
    var posts: [PostData]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        session = Session.sharedInstance
        
        session.getFrontListing() { linkListing in
            self.linkListing = linkListing
            self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard linkListing != nil else {
            return 0
        }
        return linkListing!.listing.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("Cell")
        
        if cell == nil {
            cell = UITableViewCell.init(style: UITableViewCellStyle.Subtitle, reuseIdentifier: "Cell")
        }
        
        cell!.textLabel!.text = linkListing?.listing[indexPath.row].title ?? ""
        cell!.detailTextLabel!.text = linkListing?.listing[indexPath.row].author ?? ""
        
        return cell!
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let nextViewController = RedditPostViewController()
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
}