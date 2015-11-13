//
//  APIManager.swift
//  RedditClient
//
//  Created by Travis Matthews on 11/8/15.
//  Copyright © 2015 Travis Matthews. All rights reserved.
//

import Foundation
import UIKit

class APIManager {
    
    let username = "another_test_acct"
    let password = "thisisntatest"
    let headers = [ "user-agent": "/u/another_test_acct reddit client app"]
    
    // holds current modHash for requests, needs to persist across instances
    static var modHash = ""
    
    var cookie: String?
    var url: NSURL?
    var requestType: RedditRequestType?
    
    init(requestType: RedditRequestType) {
        self.requestType = requestType
    }
    
    func login() {
        
        
    }
    
    func getAllPosts(onComplete: ([RedditPost]) -> ()) {
        switch requestType! {
            
        case .All:
            url = NSURL(string: "https://www.reddit.com/.json")!
            
        case .Front:
            url = NSURL(string: "https://www.reddit.com/.json")!
            
        default: NSLog("default clause reached within APIManager.\(requestType).getAllPosts")
        }
        
        dispatch_async(dispatch_get_global_queue(QOS_CLASS_USER_INITIATED, 0)) {
            
            guard self.url != nil else {
                return
            }
            
            if let data = try? NSData(contentsOfURL: self.url!, options: []) {
                let json = JSON(data: data)
                
                NSLog(data.debugDescription)
                
                let entries = self.parseListingJSON(json)
                
                dispatch_async(dispatch_get_main_queue()) {
                    onComplete(entries)
                }
            }
        }
    }
    
    func parseListingJSON(json: JSON) -> [RedditPost] {
        let posts = [RedditPost]()
        return posts
    }
}