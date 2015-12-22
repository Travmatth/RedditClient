//
//  RedditPostViewController.swift
//  RedditClient
//
//  Created by Travis Matthews on 12/22/15.
//  Copyright © 2015 Travis Matthews. All rights reserved.
//

import UIKit

class RedditPostViewController: UIViewController {

    var mainView: UITableView?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        mainView = UITableView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        mainView?.dataSource = self
        mainView?.delegate = self
        view.addSubview(mainView!)
        mainView?.registerClass(RedditPostCommentTableViewCell.self, forCellReuseIdentifier: "CommentCell")
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

extension RedditPostViewController: UITableViewDataSource {
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CommentCell") as? RedditPostCommentTableViewCell
        cell?.frame = CGRect(x: 0, y: 0, width: 320, height: 44)
        cell?.test("is this working")
        return cell!
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 10
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
}

extension RedditPostViewController: UITableViewDelegate {
    /*
    func tableView(tableView: UITableView, indentationLevelForRowAtIndexPath indexPath: NSIndexPath) -> Int {
        fataError("Not Implemented Yet")
    }
    */
}
