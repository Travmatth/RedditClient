//
//  LinkListing.swift
//  RedditClient
//
//  Created by Travis Matthews on 12/23/15.
//  Copyright © 2015 Travis Matthews. All rights reserved.
//

import Foundation

struct LinkListing {
    private let listing: [PostData]
    let before: String?
    let after: String?
    
    init?(fromData data: NSData) {
        var json: [String: AnyObject]
        
        do { json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as! [String: AnyObject] }
        catch let error {
            NSLog("\(error)")
            listing = []
            before = nil
            after = nil
            return
        }
        
        let linkListing = LinkListingFromJson(withJson: json)
        listing = linkListing.posts
        before = linkListing.before
        after = linkListing.after
    }
    
    subscript(index: Int) -> PostData { return listing[index] }
    
    var count: Int { return listing.count }
}

class LinkListingFromJson {
    var json: [String: AnyObject]?
    
    var before: String? {
        guard let success = json?["before"] as? String else { return nil }
        return success
    }
    
    var after: String? {
        guard let success = json?["after"] as? String else { return nil }
        return success
    }
    
    var posts: [PostData] {
        guard let rawPost = json, data = rawPost["children"] as? [[String: AnyObject]] else { return [] }
        return data.map({ PostData(withJson: $0) })
    }
    
    init(var withJson rawJson: [String: AnyObject]) {
        if let
            kind = rawJson["kind"] as? String,
            data = rawJson["data"] as? [String: AnyObject] {
                guard kind == "Listing" else { return }
                json = data
        }
    }
}