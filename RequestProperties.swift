//
//  RequestProperties.swift
//  RedditClient
//
//  Created by Travis Matthews on 11/20/15.
//  Copyright © 2015 Travis Matthews. All rights reserved.
//

import Foundation

struct RequestProperties {
    let path: String!
    let httpMethod: HTTPMethod!
    let params: [String: String]
    
    var httpParams: NSData {
        var urlQuery =  [String]()
        
        for (key,  val) in params.enumerate() {
            urlQuery.append("\(key)=\(val)")
        }
        
        return urlQuery.joinWithSeparator("&").dataUsingEncoding(NSUTF8StringEncoding)!
    }
    
    enum HTTPMethod: String {
        case Get = "GET"
        case Post = "POST"
        case Patch = "PATCH"
    }
}