//
//  RedditPost.swift
//  RedditClient
//
//  Created by Travis Matthews on 12/11/15.
//  Copyright © 2015 Travis Matthews. All rights reserved.
//

import Foundation

class RedditPost: NetworkCommunication {
    //MARK: Class variables
    var post: PostData?
    var comments: CommentTree?
    weak var session: Session! = Session.sharedInstance
    
    //MARK: Class lifecycle
    init?(dataFromNetworking data: NSData) {
        var json: Array<AnyObject>
        //var head: [String: AnyObject]
        do {
            json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as! [AnyObject]
        }
        catch let error {
            NSLog("\(error)")
            post = nil
            comments = nil
            return nil
        }
        post = PostData(withJson: json[0] as? [String: AnyObject] ?? [:])
        comments = CommentTree(json: json[1] as? [String: AnyObject] ?? [:])
    }
}