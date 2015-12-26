//
//  RedditPostViewController.swift
//  RedditClient
//
//  Created by Travis Matthews on 12/22/15.
//  Copyright © 2015 Travis Matthews. All rights reserved.
//

import UIKit

class RedditPostViewController: UIViewController, NetworkCommunication {

    var postData: PostData?
    var redditPost: RedditPost?
    var commentTableView: CommentTableView?
    var postView: PostView?
    
    weak var session: Session! = Session.sharedInstance
    
    //MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Get post info from api
        guard let postData = postData else {
            print("postData nil, returning")
            return
        }
        
        //Configure post view
        postView = PostView()
        postView?.configurePostWithData(postData)
        
        //Configure comment table
        commentTableView = CommentTableView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        commentTableView?.registerClass(RedditPostCommentTableViewCell.self, forCellReuseIdentifier: "CommentCell")
        view.addSubview(commentTableView!)
        
        session.getRedditPost(postData) { (post) in
            self.redditPost = post
            //self.commentTableModel = CommentTableModel(fromCommentTree: post?.comments)
            self.commentTableView?.dataSource = self.commentTableView
            self.commentTableView?.delegate = self.commentTableView
            self.commentTableView?.tree = post?.comments
            self.commentTableView?.reloadData()
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}