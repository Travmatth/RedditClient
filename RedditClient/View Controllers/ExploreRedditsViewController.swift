//
//  GenericRedditsTableViewController.swift
//  RedditClient
//
//  Created by Travis Matthews on 11/8/15.
//  Copyright © 2015 Travis Matthews. All rights reserved.
//

import UIKit

class ExploreRedditsViewController: UITableViewController, NetworkCommunication {
    /*
        tableview of recommended subreddits; swipe right to subscribe and left to clear
        explore users: graphs of users?
        explore subreddits: ? 
    */

    var session: Session!
    var reddits: [String] = []
    var recommender = RecommendationEngine()
    
    
    // MARK: iOS ViewController lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "dataReady:", name: "RecommendationsReady", object: nil)
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tableView!.reloadData()
    }
    
    func dataReady(_: NSNotification) {
        self.tableView!.reloadData()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
        // Find retain cycles!
        NSLog("LoginViewController.deinit")
    }
    
    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 15
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("Cell")
        
        if cell == nil {
            cell = UITableViewCell.init(style: .Subtitle, reuseIdentifier: "Cell")
        }
        
        cell!.textLabel!.text = recommender.next
        //cell!.detailTextLabel!.text = posts[indexPath.row].author
        
        return cell!
    }
}
