//
//  RedditPost.swift
//  RedditClient
//
//  Created by Travis Matthews on 12/11/15.
//  Copyright © 2015 Travis Matthews. All rights reserved.
//

import Foundation

class RedditPost {
    //MARK: Class variables
    let post: PostData?
    let comments: CommentTree?
    
    //MARK: Class lifecycle
    init?(dataFromNetworking data: NSData) {
        var json: Array<Any>
        var head: [String: AnyObject]
        var tail: [String: AnyObject]
        
        do {
            json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as! Array<AnyObject>
            head = json[0] as? [String: AnyObject] ?? [:]
            tail = json[1] as? [String: AnyObject] ?? [:]
        } catch {
            post = nil
            comments = nil
            return nil
        }
        post = PostData(withJson: head)
        comments = CommentTree(json: tail)
    }
}

class PostDataFromJson {
    var member: [String: AnyObject] = [:]
    
    init?(json: [String: AnyObject]) {
        /*There is a design flaw in this class. The RedditPost Class accepts the json of the response and splits up the post & comments, passing each off each listing. The PostData class needs to accept the listing which contains a child dictionary of type t3, yet currently only accepts the sub-data.*/
        //fatalError(error)
        let data = Parse(withJson: json).resultType
        switch data {
        case .Post(let info):
            if info != nil {
                member = info!
            }
        default: return nil
        }
        
    }
}