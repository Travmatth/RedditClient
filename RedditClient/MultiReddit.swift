//
//  MultiReddit.swift
//  RedditClient
//
//  Created by Travis Matthews on 11/20/15.
//  Copyright © 2015 Travis Matthews. All rights reserved.
//

import Foundation

struct Multi {
    
    let name: String
    let displayName: String
    let subreddits: [String]
    let descriptionHTML: String
    
    init(_ subreddits: [String], _ descriptionHTML: String, _ displayName: String, _ name: String ) {
        
        self.name = name
        self.subreddits = subreddits
        self.displayName = displayName
        self.descriptionHTML = descriptionHTML
    }
}