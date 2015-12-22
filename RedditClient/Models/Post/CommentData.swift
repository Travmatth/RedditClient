//
//  CommentData.swift
//  RedditClient
//
//  Created by Travis Matthews on 12/5/15.
//  Copyright © 2015 Travis Matthews. All rights reserved.
//

import Foundation

func == (lhs: CommentData, rhs: CommentData) -> Bool { return lhs.id == rhs.id }
/*
I want to add MoreReplies as they're own node on the comment tree; but this appears to be a nontrivial problem. To do so I would need to 
func == (lhs: MoreReplies, rhs: CommentData) -> Bool { return lhs.id == rhs.id }
func == (lhs: CommentData, rhs: MoreReplies) -> Bool { return lhs.id == rhs.id }
func == (lhs: MoreReplies, rhs: MoreReplies) -> Bool { return lhs.id == rhs.id }
*/

/* Should I implement this? */
protocol Identifiable {
    var id: String { get }
}

struct CommentDataFromJson {
    let member: [String: AnyObject]
    
    init?(withJson json: [String: AnyObject]) {
        if let
            type = json["kind"] as? String,
            data = json["data"] as? [String: AnyObject] {
                if type == "t1" {
                    member = data
                    return
                }
        }
        return nil
    }
}

struct CommentData: Equatable {
    /* Fuck it I'll use a library */
    
    init(withJson json: [String: AnyObject]) {
        let data = CommentDataFromJson(withJson: json)
        
        self.author = data?.member["author"] as? String ?? ""
        self.body = data?.member["body"] as? String ?? ""
        self.name = data?.member["name"] as? String ?? ""
        self.edited = data?.member["edited"] as? Bool ?? false
        self.score = data?.member["score"] as? Int ?? 0
        self.ups = data?.member["ups"] as? Int ?? 0
        self.downs = data?.member["downs"] as? Int ?? 0
        self.created = data?.member["created"] as? Int ?? 0
        self.saved = data?.member["saved"] as? Bool ?? false
        self.subreddit = data?.member["subreddit"] as? String ?? ""
        self.subredditId = data?.member["subreddit_id"] as? String ?? ""
        self.id = data?.member["id"] as? String ?? ""
        self.linkId = data?.member["link_id"] as? String ?? ""
        self.parentId = data?.member["parent_id"] as? String ?? ""
        self.scoreHidden = data?.member["score_hidden"] as? Bool ?? false
        self.bodyHtml = data?.member["body_html"] as? String ?? ""
        self.authorFlairCssClass = data?.member["author_flair_css_class"] as? String ?? ""
        self.authorFlairText = data?.member["author_flair_text"] as? String ?? ""
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
    
    var moreReplies: MoreReplies?
    
    mutating func addReplies(key: MoreReplies) {
        moreReplies = key
    }
}