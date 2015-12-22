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
    let id: String
    let count: Int
    let children: [String]
    let name: String
    
    init(json: [String: AnyObject]) {
        let data = MoreRepliesFromJson(withJson: json)
        
        count = data?.member["count"] as? Int ?? 0
        parentId = data?.member["parent_id"] as? String ?? ""
        name = data?.member["name"] as? String ?? ""
        id = data?.member["id"] as? String ?? ""
        var _temp: [String] = []
        if let replies = data?.member["children"] as? [AnyObject] {
            if replies.count >= 0 {
                for reply in replies {
                    _temp.append(reply as? String ?? "")
                }
            }
        }
        self.children = _temp
    }
}

struct MoreRepliesFromJson {
    let member: [String: AnyObject]
    
    init?(withJson json: [String: AnyObject]) {
        if let
            type = json["kind"] as? String,
            data = json["data"] as? [String: AnyObject] {
                if type == "more" {
                    self.member = data
                    return
                }
        }
        return nil
    }
}