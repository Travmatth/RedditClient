//
//  MultiRedditsViewController.swift
//  RedditClient
//
//  Created by Travis Matthews on 11/7/15.
//  Copyright © 2015 Travis Matthews. All rights reserved.
//

import UIKit

class MultiRedditsViewController: UITableViewController, NetworkCommunication {
    
    var session: Session!
    var multiReddits: [Multi]?
    
    // MARK: iOS ViewController lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        session.getMultiReddits() { (multi) in
            self.multiReddits = multi as? [Multi]
            self.tableView.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    // MARK: - Table View
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        guard multiReddits != nil else {return 1 }
        
        return multiReddits!.count
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard multiReddits != nil else { return 1 }
        
        return multiReddits![section].subreddits.count
    }
    
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("Cell")
        
        if cell == nil {
            cell = UITableViewCell.init(style: .Default, reuseIdentifier: "Cell")
        }
        
        let name = multiReddits?[indexPath.section].subreddits[indexPath.row]
        cell!.textLabel!.text = name
        
        return cell!
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let nextViewController = SubredditViewController()
        //let nextViewController = SubredditViewController()
        nextViewController.name = multiReddits![indexPath.section].subreddits[indexPath.row]
        nextViewController.session = session
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if multiReddits != nil {
            return multiReddits![section].name
        }
        
        return nil
    }
    
    // Find retain cycles!
    deinit {
        NSLog("LoginViewController.deinit")
    }
}
