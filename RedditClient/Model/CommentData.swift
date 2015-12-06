//
//  CommentData.swift
//  RedditClient
//
//  Created by Travis Matthews on 12/5/15.
//  Copyright © 2015 Travis Matthews. All rights reserved.
//

import Foundation

struct More {
    let id: String
    let count: Int
    let name: String
    let parentId: String
    let replyIds: [AnyObject]?
    /* Fuck it I'll use a library */
}

struct CommentData {
    let author: String
    let body: String
    let name: String
    let replies: [AnyObject]?
    
    let edited: Bool
    let score: Int
    let ups: Int
    let downs: Int
    let created: Int
    let saved: Bool
    
    let subreddit: String
    let subredditId: String
    let id: String
    let linkId: String
    let parentId: String
    
    let scoreHidden: Bool
    
    let bodyHtml: String
    let authorFlairCssClass: String
    let authorFlairText: String
    
    let kind: TypePrefix
    
    var more: More?
    
    /* Fuck it I'll use a library */
}