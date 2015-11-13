//
//  GenericRedditsTableViewController.swift
//  RedditClient
//
//  Created by Travis Matthews on 11/8/15.
//  Copyright © 2015 Travis Matthews. All rights reserved.
//

import UIKit

class GenericRedditsViewController: ListingsViewController {

    var posts = [RedditPost]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        
        tableView!.dataSource = self
        tableView!.delegate = self
        
        apiManager.getAllPosts { [unowned self] (entries) in
            self.posts = entries
            self.tableView!.reloadData()
        }
        
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
        return posts.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        var cell: UITableViewCell? = tableView.dequeueReusableCellWithIdentifier("Cell")
        
        if cell == nil {
            cell = UITableViewCell.init(style: .Subtitle, reuseIdentifier: "Cell")
        }
        
        cell!.textLabel!.text = posts[indexPath.row].title
        cell!.detailTextLabel!.text = posts[indexPath.row].author
        
        return cell!
    }
}
