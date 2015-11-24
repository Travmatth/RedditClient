//
//  Session+APIUsage.swift
//  RedditClient
//
//  Created by Travis Matthews on 11/19/15.
//  Copyright © 2015 Travis Matthews. All rights reserved.
//

import Foundation

struct APIUsage {
    var xRateLimitReset: Int!
    var xRateLimitUsed: Int!
    var xRateLimitRemaining: Int!
    
    init(response: NSURLResponse) {
        if let response = response as? NSHTTPURLResponse {
            if let val = response.allHeaderFields["x_ratelimit_reset"] as? String {
                self.xRateLimitReset = Int(val)!
            } else {
                self.xRateLimitReset = 0
            }
            
            if let val = response.allHeaderFields["x_ratelimit_used"] as? String {
                self.xRateLimitUsed = Int(val)!
            } else {
                self.xRateLimitUsed = 0
            }
            
            if let val = response.allHeaderFields["x_ratelimit_remaining"] as? String {
                self.xRateLimitRemaining = Int(val)!
            } else {
                self.xRateLimitRemaining = 0
            }
        }
    }
}