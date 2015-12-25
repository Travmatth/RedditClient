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
    var commentTableView: UITableView?
    var commentTableModel: CommentTableModel?
    weak var session: Session! = Session.sharedInstance
    
    //MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        guard let postData = postData else {
            return
        }
        
        session.getRedditPost(postData) { (post) in
            self.redditPost = post
            self.commentTableModel = CommentTableModel(fromCommentTree: self.redditPost?.comments)
            self.commentTableView?.dataSource = self.commentTableModel
            self.commentTableView?.delegate = self.commentTableModel
            self.commentTableView?.reloadData()
        }
        
        commentTableView = UITableView(frame: CGRect(x: 0, y: 0, width: view.frame.width, height: view.frame.height))
        commentTableView?.registerClass(UITableViewCell.self, forCellReuseIdentifier: "CommentCell")

        //NEED TO LOOK AT AUTOLAYOUT
        
        view.addSubview(commentTableView!)
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}
