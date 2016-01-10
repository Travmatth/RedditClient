//
//  RedditPostViewController.swift
//  RedditClient
//
//  Created by Travis Matthews on 12/22/15.
//  Copyright © 2015 Travis Matthews. All rights reserved.
//

import UIKit
import SafariServices

class RedditPostViewController: UITableViewController, CustomRefreshControl, NetworkCommunication, SubViewLaunchLinkManager {
    
    var post: PostData?
    var comments: CommentTree?
    weak var session: Session! = Session.sharedInstance
    
    //CustomRefreshControl conformance
    var isAnimating = false
    var currentColorIndex = 0
    var currentLabelIndex = 0
    var refreshView: RefreshView?
    var refreshViewLabels: [UILabel] = []
    
    //MARK: UIViewController Lifecycle methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Get post info from api
        guard let post = post else { return }
        
        //Configure comment table
        tableView.registerClass(RedditPostCommentTableViewCell.self, forCellReuseIdentifier: "CommentCell")
        let tableHeader = PostView(withPost: post, inViewController: self)
        
        //TODO: Uncommenting this line will break the layout of my view; but will also clear the NSLayoutConstraint warning?
        //tableHeader.translatesAutoresizingMaskIntoConstraints = false
        tableView.tableHeaderView = tableHeader
       
        session.getRedditPost(post) { (listing) in
            self.post = listing?.post
            self.comments = listing?.comments
            self.tableView.reloadData()
        }
        
        let recognizeLeft = UISwipeGestureRecognizer.init(target: self, action: "handleSwipeLeft:")
        let recognizeRight = UISwipeGestureRecognizer.init(target: self, action: "handleSwipeRight:")
        
        recognizeLeft.direction = .Left
        recognizeLeft.direction = .Right
        
        tableView.addGestureRecognizer(recognizeLeft)
        tableView.addGestureRecognizer(recognizeRight)
        
        //Pull-to-refresh
        refreshControl = UIRefreshControl()
        refreshControl?.tintColor = .clearColor()
        refreshControl?.backgroundColor = .clearColor()
        refreshControl?.addTarget(self, action: "refresh:", forControlEvents: .ValueChanged)
        tableView.addSubview(refreshControl!)
        tableView.sendSubviewToBack(refreshControl!)
        loadCustomRefreshContents()
        refresh()
    }
    
    //Dynamically determine the height of the tableHeaderView -> this code was the result of much effort.
    //http://collindonnell.com/2015/09/29/dynamically-sized-table-view-header-or-footer-using-auto-layout/
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        
        if let headerView = tableView.tableHeaderView {
            let height = headerView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize).height
            var headerFrame = headerView.frame
            
            //Comparison necessary to avoid infinite loop
            if height != headerFrame.size.height {
                headerFrame.size.height = height
                headerView.frame = headerFrame
                tableView.tableHeaderView = headerView
            }
        }
    }
    
    
    override func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        print("scrollViewDidEndDecelerating called")
        if refreshControl?.refreshing == true {
            if !isAnimating {
                refreshView?.setNeedsLayout()
                refreshView?.layoutIfNeeded()
                animateRefreshStep1()
            }
        }
    }
    
    override func viewWillAppear(animated: Bool) {
        refresh()
    }
    
    //MARK: UITableViewDataSource
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CommentCell") as? RedditPostCommentTableViewCell
        
        cell?.configureCell(fromComment: comments?.flatten?[indexPath.row])
        cell?.layoutIfNeeded()
        
        return cell!
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int { return comments?.flatten?.count ?? 0 }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int { return 1 }
    
    override func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let cell = tableView.dequeueReusableCellWithIdentifier("CommentCell") as? RedditPostCommentTableViewCell
        cell?.configureCell(fromComment: comments?.flatten?[indexPath.row])
        let size = cell?.contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize)
        return size?.height ?? 100.0
    }

    //MARK: Accessory Functions
    func refresh(refreshControl: UIRefreshControl? = nil) {
        guard let post = self.post else { return }
        refreshControl?.beginRefreshing()
        session.getRedditPost(post) { (post) in
            self.post = post?.post
            self.comments = post?.comments
            self.tableView.reloadData()
            self.refreshControl?.endRefreshing()
        }
    }
    
    func launchLink(sender: UIButton) {
        if let address = post?.url, url = NSURL(string: address) {
            let browser = SFSafariViewController(URL: url)
            navigationController?.presentViewController(browser, animated: true, completion: nil)
        }
    }
    
    func handleSwipeLeft(gestureRecognizer: UISwipeGestureRecognizer) {
        let location: CGPoint = gestureRecognizer.locationInView(self.tableView)
        
        //Corresponding indexPath of swipe 
        if let indexPath: NSIndexPath = self.tableView.indexPathForRowAtPoint(location),
               _ = tableView.cellForRowAtIndexPath(indexPath) as? RedditPostCommentTableViewCell { }
    }
    
    func handleSwipeRight(gestureRecognizer: UISwipeGestureRecognizer) {
        let location: CGPoint = gestureRecognizer.locationInView(self.tableView)
        
        //Corresponding indexPath of swipe 
        if let indexPath: NSIndexPath = self.tableView.indexPathForRowAtPoint(location),
               _ = tableView.cellForRowAtIndexPath(indexPath) as? RedditPostCommentTableViewCell { }
    }
}