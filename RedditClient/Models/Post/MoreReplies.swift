//
//  PostData.swift
//  RedditClient
//
//  Created by Travis Matthews on 12/6/15.
//  Copyright © 2015 Travis Matthews. All rights reserved.
//

import Foundation



struct MoreReplies {
    let parentId: String
    let count: Int
    let children: [String]
    let name: String
    
    init(json: [String: AnyObject]) {
        count = json["count"] as? Int ?? 0
        parentId = json["parent_id"] as? String ?? ""
        name = json["name"] as? String ?? ""
        
        var _temp: [String] = []
        if let replies = json["children"] as? [AnyObject] {
            if replies.count >= 0 {
                for reply in replies {
                    _temp.append(reply as? String ?? "")
                }
            }
        }
        self.children = _temp
    }
}