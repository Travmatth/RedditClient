//
//  CommentData.swift
//  RedditClient
//
//  Created by Travis Matthews on 12/5/15.
//  Copyright © 2015 Travis Matthews. All rights reserved.
//

import Foundation

func == (lhs: CommentData, rhs: CommentData) -> Bool { return lhs.id == rhs.id }

struct CommentData: Equatable {
    /* Fuck it I'll use a library */
    
    init(withJson json: [String: AnyObject]) {
        self.author = json["author"] as? String ?? ""
        self.body = json["body"] as? String ?? ""
        self.name = json["name"] as? String ?? ""
        self.edited = json["edited"] as? Bool ?? false
        self.score = json["score"] as? Int ?? 0
        self.ups = json["ups"] as? Int ?? 0
        self.downs = json["downs"] as? Int ?? 0
        self.created = json["created"] as? Int ?? 0
        self.saved = json["saved"] as? Bool ?? false
        self.subreddit = json["subreddit"] as? String ?? ""
        self.subredditId = json["subreddit_id"] as? String ?? ""
        self.id = json["id"] as? String ?? ""
        self.linkId = json["link_id"] as? String ?? ""
        self.parentId = json["parent_id"] as? String ?? ""
        self.scoreHidden = json["score_hidden"] as? Bool ?? false
        self.bodyHtml = json["body_html"] as? String ?? ""
        self.authorFlairCssClass = json["author_flair_css_class"] as? String ?? ""
        self.authorFlairText = json["author_flair_text"] as? String ?? ""
    }
    
    let ups: Int
    let score: Int
    let downs: Int
    let created: Int
    
    let saved: Bool
    let edited: Bool
    let scoreHidden: Bool
    
    let id: String
    let body: String
    let name: String
    let author: String
    let linkId: String
    let parentId: String
    let bodyHtml: String
    let subreddit: String
    let subredditId: String
    let authorFlairText: String
    let authorFlairCssClass: String
    
    var more: MoreReplies?
    
    mutating func addReplies(replies: MoreReplies) {
        self.more = replies
    }
}