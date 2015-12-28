//
//  PostView.swift
//  RedditClient
//
//  Created by Travis Matthews on 12/25/15.
//  Copyright © 2015 Travis Matthews. All rights reserved.
//

import UIKit
import Foundation

class PostViewManager {
    class func configurePostViewWithData(post: PostData, inViewController viewController: RedditPostViewController) -> UIView {
        let postView = UIView()
        postView.backgroundColor = UIColor.whiteColor()
        
        /*
        let scrollView = UIScrollView()
        scrollView.showsVerticalScrollIndicator = true
        scrollView.scrollEnabled = true
        scrollView.userInteractionEnabled = true
        //scrollView.contentS
        */
    
        let launchLink = UIButton()
        let selfText = UILabel()
        let body = UILabel()
        let domain = UILabel()
        let author = UILabel()
        let numComments = UILabel()
        
        launchLink.setImage(UIImage(named: "circle-user-7"), forState: .Normal)
        launchLink.addTarget(viewController, action: "launchLink:", forControlEvents: .TouchUpInside)

        selfText.numberOfLines = 0
        selfText.lineBreakMode = .ByWordWrapping
        let attributedString = NSAttributedString(string: post.selfTextHtml, attributes: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType])
        selfText.attributedText = attributedString
        
        body.text = post.title
        body.numberOfLines = 0
        body.lineBreakMode = .ByWordWrapping
        
        domain.text = post.domain
        author.text = post.author
        numComments.text = "\(post.numComments)"
        
        
        postView.addSubview(body)
        postView.addSubview(selfText)
        postView.addSubview(domain)
        postView.addSubview(author)
        postView.addSubview(numComments)
        postView.addSubview(launchLink)
        
        body.translatesAutoresizingMaskIntoConstraints = false
        domain.translatesAutoresizingMaskIntoConstraints = false
        author.translatesAutoresizingMaskIntoConstraints = false
        selfText.translatesAutoresizingMaskIntoConstraints = false
        launchLink.translatesAutoresizingMaskIntoConstraints = false
        numComments.translatesAutoresizingMaskIntoConstraints = false
        
        let views: [String: UIView] = ["body": body, "domain": domain, "author": author, "numComments": numComments, "launchLink": launchLink, "selfText": selfText]
        
        //var allConstraints = [NSLayoutConstraint]()
        
        postView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[body]-[selfText]-[domain]|", options: [], metrics: nil, views: views))
        postView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[body]-[selfText]-[author]|", options: [], metrics: nil, views: views))
        postView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[body]-[selfText]-[numComments]|", options: [], metrics: nil, views: views))
        postView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[launchLink]-[numComments]|", options: [], metrics: nil, views: views))
        postView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[body][launchLink]|", options: [], metrics: nil, views: views))
        postView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[selfText][launchLink]|", options: [], metrics: nil, views: views))
        postView.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[domain][author][numComments][launchLink]|", options: [], metrics: nil, views: views))
        
        //NSLayoutConstraint.activateConstraints(allConstraints)
        //postView.addConstraints(allConstraints)
        
        //postView.addSubview(postView)
        //postView.userInteractionEnabled = true
        postView.backgroundColor = UIColor.whiteColor()
        return postView
    }
}