//
//  ViewController.swift
//  RedditClient
//
//  Created by Travis Matthews on 11/7/15.
//  Copyright © 2015 Travis Matthews. All rights reserved.
//

import UIKit

class ProfileViewController: UITableViewController, NetworkCommunication {

    // TODO: Refactor; remove Settings as VC & subclass as popup; add launch icon to all navbar controllers; subclass navbar?
    // also use her tip of typealias multi = <All, the, protocols, i, conform, to>
    // http://natashatherobot.com/ios-taking-the-user-to-settings/ 
    
    weak var session: Session!
    
    let cellTitles = ["User", "Inbox", "Posts", "Comments", "Subscriptions", "Explore", "Settings"]
    
    // MARK: iOS ViewController lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
    }

    override func didReceiveMemoryWarning() { super.didReceiveMemoryWarning() }
    
    // MARK: - Table View
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int { return 1 }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return cellTitles.count }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell: UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("Cell")
        cell!.textLabel!.text = cellTitles[indexPath.row]
        
        return cell!
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let nextViewController = MultiRedditsViewController()
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
}

