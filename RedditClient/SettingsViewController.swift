//
//  ViewController.swift
//  RedditClient
//
//  Created by Travis Matthews on 11/7/15.
//  Copyright © 2015 Travis Matthews. All rights reserved.
//

import UIKit

class SettingsViewController: ListingsViewController {

    // TODO: Refactor; remove Settings as VC & subclass as popup; add launch icon to all navbar controllers; subclass navbar?
    // also use her tip of typealias multi = <All, the, protocols, i, conform, to>
    // http://natashatherobot.com/ios-taking-the-user-to-settings/ 
    let cellTitles = ["User", "Inbox", "Posts", "Comments", "Subscriptions", "Explore", "Settings"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table View
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return cellTitles.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("Cell")
        
        if cell == nil {
            cell = UITableViewCell.init(style: .Default, reuseIdentifier: "Cell")
        }
        
        cell!.textLabel!.text = cellTitles[indexPath.row]
        
        return cell!
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        NSLog("indexPath: \(indexPath)")
        let nextViewController = MultiRedditsViewController()
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }

    
    // Find retain cycles!
    deinit {
        NSLog("LoginViewController.deinit")
    }


}

