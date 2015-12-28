//
//  RedditPostViewController.swift
//  RedditClient
//
//  Created by Travis Matthews on 12/22/15.
//  Copyright © 2015 Travis Matthews. All rights reserved.
//

import UIKit
import SafariServices

class RedditPostViewController: UIViewController, NetworkCommunication {

    var scrollView: UIScrollView?
    
    var postData: PostData?
    var postView: UIView?
    var redditPost: RedditPost?
    var commentTableView: CommentTableView?
    
    weak var session: Session! = Session.sharedInstance
    
    func launchLink(sender: UIButton) {
        if let post = postData, url = NSURL(string: post.url) {
            let nextViewController = SFSafariViewController(URL: url)
            self.navigationController?.presentViewController(nextViewController, animated: true, completion: nil)
        }
    }
    
    //MARK: Lifecycle Methods
    override func viewDidLoad() {
        super.viewDidLoad()

        // Get post info from api
        guard let postData = postData else {
            print("postData nil, returning")
            return
        }
        
        //Configure post view
        postView = PostViewManager.configurePostViewWithData(postData, inViewController: self)
        scrollView = UIScrollView()
        scrollView?.addSubview(postView!)
        scrollView?.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[postView]|", options: [], metrics: nil, views: ["postView": postView!]))
        scrollView?.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|[postView]|", options: [], metrics: nil, views: ["postView": postView!]))
        
        scrollView?.backgroundColor = UIColor.whiteColor()
        
        //Configure comment table
        commentTableView = CommentTableView()
        commentTableView?.registerClass(RedditPostCommentTableViewCell.self, forCellReuseIdentifier: "CommentCell")
        
        postView?.translatesAutoresizingMaskIntoConstraints = false
        commentTableView?.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(scrollView!)
        view.addSubview(commentTableView!)
        
        let topGuide = self.topLayoutGuide
        let views: [String: AnyObject] = ["post": postView!, "comments": commentTableView!, "top": topGuide]
        
        var allConstraints = [NSLayoutConstraint]()
        
        let verticalConstraint = NSLayoutConstraint.constraintsWithVisualFormat("V:|[top][post][comments]|", options: [], metrics: nil, views: views)
        let horizontalConstraintTop = NSLayoutConstraint.constraintsWithVisualFormat("H:|[post]|", options: [], metrics: nil, views: views)
        let horizontalConstraintBottom = NSLayoutConstraint.constraintsWithVisualFormat("H:|[comments]|", options: [], metrics: nil, views: views)

        allConstraints += verticalConstraint + horizontalConstraintTop + horizontalConstraintBottom
        NSLayoutConstraint.activateConstraints(allConstraints)
        self.view.addConstraints(allConstraints)
        
        session.getRedditPost(postData) { (post) in
            self.redditPost = post
            //self.commentTableModel = CommentTableModel(fromCommentTree: post?.comments)
            self.commentTableView?.dataSource = self.commentTableView
            self.commentTableView?.delegate = self.commentTableView
            self.commentTableView?.tree = post?.comments
            self.commentTableView?.reloadData()

        }
    }
    
    override func viewWillAppear(animated: Bool) {
        print("\(self.postView!.frame)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
}