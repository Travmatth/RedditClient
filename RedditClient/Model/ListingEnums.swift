//
//  CommentTree.swift
//  RedditClient
//
//  Created by Travis Matthews on 12/3/15.
//  Copyright © 2015 Travis Matthews. All rights reserved.
//

import Foundation

enum TypePrefix: String {
    case Comment = "t1"
    case Account = "t2"
    case Link = "t3"
    case Message = "t4"
    case Subreddit = "t5"
    case Award = "t6"
    case PromoCampaign = "t8"
    case Null = ""
}

/*
POST /api/set_suggested_sortmodposts
Set a suggested sort for a link.
Suggested sorts are useful to display comments in a certain preferred way for posts. For example, casual conversation may be better sorted by new by default, or AMAs may be sorted by Q&A. A sort of an empty string clears the default sort.
*/
enum Sort: String {
    case Confidence = "confince"
    case Top = "top"
    case New = "new"
    case Hot = "hot"
    case Controversial = "controversial"
    case Old = "old"
    case Random = "random"
    case QA = "qa"
    case Blank = ""
}