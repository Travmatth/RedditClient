//
//  GenericRedditsTableViewController.swift
//  RedditClient
//
//  Created by Travis Matthews on 11/8/15.
//  Copyright © 2015 Travis Matthews. All rights reserved.
//

import UIKit

class GenericRedditsViewController: UITableViewController {

    var pageType: RedditPageTypes?
    var posts = [RedditPost]()
    var apiManager: APIManager!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        let apiManager = APIManager()
        
        tableView!.dataSource = self
        tableView!.delegate = self
        
        guard pageType != nil else {
            NSLog("pageType not set within GenericRedditControllers")
            return
        }
        
        switch pageType! {
        case .All:
            apiManager.getAllPosts {
                [unowned self] (entries) in
                
                self.posts = entries
                self.tableView!.reloadData()
            }
            
        case .Front: fallthrough
            
        default: NSLog("default clause reached within .\(pageType).viewDidLoad")
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
