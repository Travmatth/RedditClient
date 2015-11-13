//
//  Structs & Constants.swift
//  RedditClient
//
//  Created by Travis Matthews on 11/8/15.
//  Copyright © 2015 Travis Matthews. All rights reserved.
//

import Foundation
import UIKit

enum RedditRequestType {
    case Front
    case All
    case Account
}

enum TypePrefix: String {
    case Comment = "t1"
    case Account = "t2"
    case Link = "t3"
    case Message = "t4"
    case Subreddit = "t5"
    case Award = "t6"
    case PromoCampaign = "t8"
}

protocol RedditPost {
    var title: String { get }
    var author: String { get }
    
}

struct TextPost: RedditPost {
    let title: String
    let author: String
    
}

struct LinkPost: RedditPost {
    let kind: TypePrefix
    let domain: String
    let subreddit: String
    let id: String
    let clicked: Bool
    let author: String
    let nsfw: Bool
    let hidden: Bool
    // Do I need to grab this? not rght now for sure
    //let thumbnail: UIImage
    let thumbnailUrl: String
    let commentCount: String
    let subredditId: String
    let edited:	Bool
    let downs:	Int
    let saved:	Bool
    let permalink: String
    let name: String
    let created: Int
    let url: String
    let title: String
    let created_utc: Int
    let visited: Bool
    let ups: Int
}
