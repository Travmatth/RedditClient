//
//  Session+Listing.swift
//  RedditClient
//
//  Created by Travis Matthews on 11/29/15.
//  Copyright © 2015 Travis Matthews. All rights reserved.
//

import Foundation

extension Session {
    func getFrontListing(onCompletion: (LinkListing?) -> Void) {
        let listingTarget = RequestProperties(path: "", httpMethod:  .Get, params: nil, paramsList: nil)
        guard self.user?.oauthToken != nil else {
            return
        }
        
        if let request: NSMutableURLRequest = oauthAuthenticatedRequest(listingTarget) {
            let task = session.dataTaskWithRequest(request) { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
                let result = resultFromOptionalError(Response(data: data, urlResponse: response), optionalError: error)
                             .flatMap(acceptableStatusCode)
                
                switch result {
                    
                case .Success(let jsonData):
                    let linkListing = LinkListing(fromData: jsonData)
                    dispatch_async(dispatch_get_main_queue()) { onCompletion(linkListing) }
                    
                case .Failure(let error):
                    NSLog("\(error)")
                }
            }
            task.resume()
        }
    }
}

struct LinkListing {
    let listing: [PostData]
    let before: String?
    let after: String?
    
    init?(fromData data: NSData) {
        var json: [String: AnyObject]
        
        do {
            json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as! [String: AnyObject]
        }
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
}

class LinkListingFromJson {
    var json: [String: AnyObject]?
    
    var before: String? {
        guard json != nil else { return nil }
        return json!["before"] as? String ?? nil
    }
    
    var after: String? {
        guard json != nil else { return nil }
        return json!["after"] as? String ?? nil
        
    }
    
    var posts: [PostData] {
        guard json != nil else { return [] }
        var _posts: [PostData] = []
        if let data = json!["Children"] as? [[String: AnyObject]] {
            for post in data {
                _posts.append(PostData(withJson: post))
            }
        }
        return _posts
        
    }
    
    init(var withJson json: [String: AnyObject]) {
        if let
            kind = json["kind"] as? String,
            data = json["data"] as? [String: AnyObject] {
                guard kind == "Listing" else { return }
                json = data
        }
    }
}