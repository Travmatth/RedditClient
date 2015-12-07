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
    
    /*
    init(json: JSON) {
        self.author =
        self.body =
        self.name =
        self.kind =
        self.replies =
        self.edited =
        self.score =
        self.ups =
        self.downs =
        self.created =
        self.saved =
        self.subreddit =
        self.subredditId =
        self.id = id
        self.linkId =
        self.parentId =
        self.scoreHidden =
        self.bodyHtml =
        self.authorFlairCssClass =
        self.authorFlairText =
    }
    */
    
    var more: More?
    
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
    
    let replies: [String] = []
    
    let kind: TypePrefix

    struct More {
        let id: String
        let count: Int
        let name: String
        let parentId: String
        let replyIds: [AnyObject]?
        /* Fuck it I'll use a library */
    }
}