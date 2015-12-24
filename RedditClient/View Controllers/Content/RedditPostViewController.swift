//
//  RedditPostViewController.swift
//  RedditClient
//
//  Created by Travis Matthews on 12/22/15.
//  Copyright © 2015 Travis Matthews. All rights reserved.
//

import UIKit

class RedditPostViewController: UIViewController {

    var postData: PostData?
    var redditPost: RedditPost?
    var commentTableView: UITableView?
    var commentTableModel: CommentTableModel?
    
    //MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        redditPost = RedditPost(fromPostData: postData) { redditPost in
            if redditPost == nil { fatalError("redditPost failed init") }
            self.redditPost = redditPost
            self.commentTableModel = CommentTableModel(fromCommentTree: redditPost?.comments)
            if self.commentTableModel == nil { fatalError("redditPost failed init") }
            self.commentTableView?.reloadData()
        }
        
        /*
        guard let commentTableModel = commentTableModel else {
            return
        }*/
        
        commentTableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        commentTableView?.dataSource = commentTableModel
        commentTableView?.delegate = commentTableModel
        commentTableView?.registerClass(RedditPostCommentTableViewCell.self, forCellReuseIdentifier: "CommentCell")

        //NEED TO LOOK AT AUTOLAYOUT
        view.addSubview(commentTableView!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}

class CommentTableModel: NSObject {
    var tree: CommentTree?
    init?(fromCommentTree tree: CommentTree?) {
        self.tree = tree
        return
    }
}

extension CommentTableModel: UITableViewDataSource {
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

extension CommentTableModel: UITableViewDelegate {
    /*
    func tableView(tableView: UITableView, indentationLevelForRowAtIndexPath indexPath: NSIndexPath) -> Int {
        fataError("Not Implemented Yet")
    }
    */
}
