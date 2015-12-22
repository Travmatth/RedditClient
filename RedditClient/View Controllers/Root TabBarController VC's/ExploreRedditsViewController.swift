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
        
        tap on subreddit cell to retrieve info about subreddit
    
        Use container view to switch on user recommendations? 
        viewWillAppear() -> subscriptions available? 
    
        http://www.raywenderlich.com/21842/how-to-make-a-gesture-driven-to-do-list-app-part-13
        http://jademind.com/blog/posts/swipe-gestures-on-uitableview/
    */

    weak var session: Session!
    var reddits: [String] = []
    var recommender = RecommendationEngine()
    
    // MARK: TableView Gesture Recognizer Actions
    func handleSwipeLeft(gestureRecognizer: UISwipeGestureRecognizer) {
        //Location of swipe
        let location: CGPoint = gestureRecognizer.locationInView(self.tableView)
        
        //Corresponding indexPath of swipe 
        if let indexPath: NSIndexPath = tableView.indexPathForRowAtPoint(location) {
            let swipedCell: UITableViewCell = tableView!.cellForRowAtIndexPath(indexPath)!
            swipedCell.textLabel!.text = "Swiped!"
        }
    }
    
    func handleSwipeRight(gestureRecognizer: UISwipeGestureRecognizer) {
        //Location of swipe
        let location: CGPoint = gestureRecognizer.locationInView(self.tableView)
        
        //Corresponding indexPath of swipe 
        if let indexPath: NSIndexPath = tableView.indexPathForRowAtPoint(location) {
            let swipedCell: UITableViewCell = tableView!.cellForRowAtIndexPath(indexPath)!
            swipedCell.textLabel!.text = "Swiped!"
        }
    }
    
    // MARK: iOS ViewController lifecycle methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "dataReady:", name: "NewRecommendations", object: nil)
        
        //Add swiping capability to cells
        let recognizeLeft = UISwipeGestureRecognizer.init(target: self, action: "handleSwipeLeft:")
        let recognizeRight = UISwipeGestureRecognizer.init(target: self, action: "handleSwipeRight:")
        
        recognizeLeft.direction = .Left
        recognizeLeft.direction = .Right
        
        self.tableView.addGestureRecognizer(recognizeLeft)
        self.tableView.addGestureRecognizer(recognizeRight)
        
        refreshTableData()
        
        fatalError("See Todo")
        //TODO: Current situation:
        /*
        - oauth login flow posts token retrieval
        - recommendation pipeline is notified, begins retrieving seeds
        - seeds pushed onto intelligent stack, which then notifies when loaded
        - recommendation pipeline catches notification, begins retrieving recommendations and posts newrecommendation notices
        - viewcontroller is created, pulls recommendations from model, will update itself on future recommendations
        
        improved flow?: 
        - move oauthtoken flow to user
        - move karmabreakdown to user; pass info as needed to recommendation pipeline?
        - recommendation pipeline should rely on user, not on login flow to start
        */
    }
    
    override func viewWillAppear(animated: Bool) {
        self.tableView!.reloadData()
    }
    
    func dataReady(_: NSNotification) {
        refreshTableData()
    }
    
    func refreshTableData() {
        //Add reddits to recommendations
        recommender.retrieveRecommendations() { newRecommendations -> Void in
            self.reddits += newRecommendations
        }
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
        
        if !reddits.isEmpty {
            cell!.textLabel!.text = reddits[indexPath.row]
        }
        //cell!.detailTextLabel!.text = posts[indexPath.row].author
        
        return cell!
    }
    
    override func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        /* Should show some information on the chosen subreddit?
        */
    }
}