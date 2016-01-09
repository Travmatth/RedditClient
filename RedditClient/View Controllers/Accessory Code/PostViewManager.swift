//
//  PostView.swift
//  RedditClient
//
//  Created by Travis Matthews on 12/25/15.
//  Copyright © 2015 Travis Matthews. All rights reserved.
//

import UIKit
import Foundation

protocol SubViewLaunchLinkManager: class {
    func launchLink(sender: UIButton)
}

class PostView: UIView {
    
    var body: UILabel?
    var post: PostData?
    var domain: UILabel?
    var author: UILabel?
    var selfText: UILabel?
    var numComments: UILabel?
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("Not implemented yet")
    }

    init(withPost post: PostData, inViewController viewController: SubViewLaunchLinkManager) {
        super.init(frame: CGRectZero)
        
        self.post = post
        self.backgroundColor = UIColor.lightGrayColor()
        
        let launchLink = UIButton()
        launchLink.setImage(UIImage(named: "circle-user-7"), forState: .Normal)
        launchLink.addTarget(viewController, action: "launchLink:", forControlEvents: .TouchUpInside)
        launchLink.setContentCompressionResistancePriority(900, forAxis: .Horizontal)
        self.addSubview(launchLink)

        selfText = UILabel()
        selfText?.backgroundColor = UIColor.whiteColor()
        selfText?.numberOfLines = 0
        selfText?.lineBreakMode = .ByWordWrapping
        selfText!.text = post.selfText
        //let attributedString = NSAttributedString(string: post.selfTextHtml, attributes: [NSDocumentTypeDocumentAttribute: NSHTMLTextDocumentType])
        //selfText?.attributedText = attributedString
        self.addSubview(selfText!)
        
        body = UILabel()
        body!.text = post.title
        body!.numberOfLines = 0
        body!.lineBreakMode = .ByWordWrapping
        body!.textAlignment = .Justified
        self.addSubview(body!)
        
        domain = UILabel()
        domain!.text = post.domain
        self.addSubview(domain!)
        
        author = UILabel()
        author!.text = post.author
        self.addSubview(author!)
        
        numComments = UILabel()
        numComments!.text = "\(post.numComments)"
        self.addSubview(numComments!)
        
        body!.translatesAutoresizingMaskIntoConstraints = false
        domain!.translatesAutoresizingMaskIntoConstraints = false
        author!.translatesAutoresizingMaskIntoConstraints = false
        selfText!.translatesAutoresizingMaskIntoConstraints = false
        launchLink.translatesAutoresizingMaskIntoConstraints = false
        numComments!.translatesAutoresizingMaskIntoConstraints = false
        
        let views: [String: UIView] = ["body": body!, "domain": domain!, "author": author!, "numComments": numComments!, "launchLink": launchLink, "selfText": selfText!]
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[body]-[selfText]-[domain]-|", options: [], metrics: nil, views: views))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[body]-[selfText]-[author]-|", options: [], metrics: nil, views: views))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[body]-[selfText]-[numComments]-|", options: [], metrics: nil, views: views))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("V:|-[launchLink]-[selfText]-[numComments]-|", options: [], metrics: nil, views: views))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[body][launchLink]|", options: [], metrics: nil, views: views))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|-[selfText]-|", options: [], metrics: nil, views: views))
        self.addConstraints(NSLayoutConstraint.constraintsWithVisualFormat("H:|[domain][author][numComments]|", options: [], metrics: nil, views: views))
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        body?.preferredMaxLayoutWidth = body!.bounds.width
        selfText?.preferredMaxLayoutWidth = selfText!.bounds.width
    }
}