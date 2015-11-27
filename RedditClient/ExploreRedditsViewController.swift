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
    */

    var session: Session!
    var reddits: [String] = []
    let recommendations = RecommendationEngine()
    
    // MARK: iOS ViewController lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        self.tableView!.reloadData()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
        
    }

    // MARK: - Table view data source

    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return reddits.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("Cell")
        
        if cell == nil {
            cell = UITableViewCell.init(style: .Subtitle, reuseIdentifier: "Cell")
        }
        
        cell!.textLabel!.text = recommendations.nextRecommendation
        //cell!.detailTextLabel!.text = posts[indexPath.row].author
        
        return cell!
    }
    
    // Find retain cycles!
    deinit {
        NSLog("LoginViewController.deinit")
    }
}