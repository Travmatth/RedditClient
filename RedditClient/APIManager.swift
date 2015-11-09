//
//  APIManager.swift
//  RedditClient
//
//  Created by Travis Matthews on 11/8/15.
//  Copyright © 2015 Travis Matthews. All rights reserved.
//

import Foundation
import UIKit

class APIManager {
    var posts = [RedditPost]()
    
    func getAllPosts(onComplete: ([RedditPost]) -> ()) {
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)) {
            let url = NSURL(string: "https://www.reddit.com/.json")!
            
            if let data = try? NSData(contentsOfURL: url, options: []) {
                let json = JSON(data: data)
                
                let entries = self.parseJSON(json)
                
                dispatch_async(dispatch_get_main_queue()) {
                    onComplete(entries)
                }
            }
        }
    }
    
    func parseJSON(json: JSON) -> [RedditPost] {
        var posts = [RedditPost]()
        
        for post in json["data"]["children"].arrayValue {
            let kind = TypePrefix(rawValue: post["kind"].stringValue)
            
            // TODO: better var name?
            let jsonChild = post["data"]
            
            let domain = jsonChild["domain"].stringValue
            let subreddit = jsonChild["subreddit"].stringValue
            let id = jsonChild["id"].stringValue
            let clicked = jsonChild["clicked"].boolValue
            let author = jsonChild["author"].stringValue
            let nsfw = jsonChild["over_18"].boolValue
            let hidden = jsonChild["hidden "].boolValue
            let thumbnailUrl = jsonChild["thumbnail"].stringValue
            let commentCount = jsonChild["num_comments"].stringValue
            let subredditId = jsonChild["subreddit_id"].stringValue
            let edited = jsonChild["edited"].boolValue
            let downvotes = jsonChild["downs"].intValue
            let saved = jsonChild["saved"].boolValue
            let permalink = jsonChild["permalink"].stringValue
            let name = jsonChild["name"].stringValue
            let created = jsonChild["created"].intValue
            let url = jsonChild["url"].stringValue
            let title = jsonChild["title"].stringValue
            let createdUTC = jsonChild["created_utc "].intValue
            let visited = jsonChild["visited "].boolValue
            let upvotes = jsonChild["ups "].intValue
            
            let entry = LinkPost(kind: kind!, domain: domain, subreddit: subreddit, id: id, clicked: clicked, author: author, nsfw: nsfw, hidden: hidden, thumbnailUrl: thumbnailUrl, commentCount: commentCount, subredditId: subredditId, edited:	edited, downs:	downvotes, saved:	saved, permalink: permalink, name: name, created: created, url: url, title: title, created_utc: createdUTC, visited: visited, ups: upvotes)
            
            posts.append(entry)
        }
        
        return posts
    }
}
