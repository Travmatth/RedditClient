//
//  PostView.swift
//  RedditClient
//
//  Created by Travis Matthews on 12/25/15.
//  Copyright © 2015 Travis Matthews. All rights reserved.
//

import UIKit
import Foundation

class PostView: UIView {
    var postData: PostData?
    
    var bodyLabel: UILabel?
    var subreddit: UILabel?
    var authorLabel: UILabel?
    var numCommentsLabel: UILabel?
    
    func configurePostWithData(post: PostData) {
        fatalError("next up!")
        postData = post
    }

    convenience init() {
        self.init()
    }
}
