//
//  Subreddit.swift
//  RedditClient
//
//  Created by Travis Matthews on 11/26/15.
//  Copyright © 2015 Travis Matthews. All rights reserved.
//

import Foundation

struct Post {
    let before: String?
    let after: String?
    
    let kind: String!
    let id: String!
    let selfText: String!
    let ups: Int!
    let linkFlairText: String!
    let archived: Bool!
    let clicked: Bool!
    let author: String!
    let media: Any!
    let nsfw: Bool!
    let hidden: Bool!
    let numComments: Int!
    let thumbNail: Any!
    let saved: Bool!
    let permalink: String!
    let locked: Bool!
    let name: String!
    let created: Int!
    let authorFlairText: Any!
    let title: String!
    let createdUTC: Int!
    let distinguished: Any!
    let visited: Bool!
    let subreddit: String!
    let subredditId: String!
    
    init(_ before: String!, _ after: String!, _ kind: String!, _ id: String!, _ selfText: String!, _ ups: Int!, _ linkFlairText: String!, _ archived: Bool!, _ clicked: Bool!, _ author: String!, _ media: Any!, _ nsfw: Bool!, _ hidden: Bool!, _ numComments: Int!, _ thumbNail: Any!, _ saved: Bool!, _ permalink: String!, _ locked: Bool!, _ name: String!, _ created: Int!, _ authorFlairText: Any!, _ title: String!, _ createdUTC: Int!, _ distinguished: Any!, _ visited: Bool!, _ subreddit: String!, _ subredditId: String!) {
        self.before = before
        self.after = after
        self.kind = kind
        self.id = id
        self.selfText = selfText
        self.ups = ups
        self.linkFlairText = linkFlairText
        self.archived = archived
        self.clicked = clicked
        self.author = author
        self.media = media
        self.nsfw = nsfw
        self.hidden = hidden
        self.numComments = numComments
        self.thumbNail = thumbNail
        self.saved = saved
        self.permalink = permalink
        self.locked = locked
        self.name = name
        self.created = created
        self.authorFlairText = authorFlairText
        self.title = title
        self.createdUTC = createdUTC
        self.distinguished = distinguished
        self.visited = visited
        self.subreddit = subreddit
        self.subredditId = subredditId
    }
}