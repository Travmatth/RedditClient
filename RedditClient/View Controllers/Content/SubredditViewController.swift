//
//  SubredditTableViewController.swift
//  RedditClient
//
//  Created by Travis Matthews on 11/26/15.
//  Copyright © 2015 Travis Matthews. All rights reserved.
//

import UIKit
import SafariServices


class SubredditViewController: UITableViewController, NetworkCommunication {

    //
    var name: String!
    weak var session: Session!
    var linkListing: LinkListing?
    var linkButtons: [UIButton] = []
    
    //var posts: [PostData]?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem()
        
        session = Session.sharedInstance
        
        session.getSubredditPosts(name) { linkListing in
            self.linkListing = linkListing
            self.tableView.reloadData()
        }
        
        self.tableView.registerClass(SelfPostCell.self, forCellReuseIdentifier: "SelfPostCell")
        self.tableView.registerClass(ExternalPostCell.self, forCellReuseIdentifier: "ExternalPostCell")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //MARK: - Access viewController properties
    func dequeueCell(id: String) -> UITableViewCell? {
        return self.tableView.dequeueReusableCellWithIdentifier(id)
    }
    
    func addButton(button: UIButton) {
        linkButtons.append(button)
    }
    
    func launchLink(sender: UIButton) {
        if let
            address = linkListing?[sender.tag].url,
            link = NSURL(string: address) {
                let browser = SFSafariViewController(URL: link)
                self.navigationController?.presentViewController(browser, animated: true, completion: nil)
        }
    }
    
    // MARK: - Table view data source
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let linkListing = linkListing else {
            return 0
        }
        return linkListing.count
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let post = (linkListing?[indexPath.row])!
        return SubredditPostManager.createCellForSubredditListing(self, fromPost: post, atIndexPath: indexPath.row)
    }
    
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        //let cell = tableView.dequeueReusableCellWithIdentifier("CommentCell")
        //cell?.configureCell(fromComment: tree?.flatten?[indexPath.row])
        //let size = cell?.contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize)
        return /*size?.height ??*/ 100.0
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let nextViewController = RedditPostViewController()
        nextViewController.postData = linkListing?[indexPath.row]
        self.navigationController?.pushViewController(nextViewController, animated: true)
    }
}
