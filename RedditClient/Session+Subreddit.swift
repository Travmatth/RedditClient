//
//  Session+Subreddit.swift
//  RedditClient
//
//  Created by Travis Matthews on 11/26/15.
//  Copyright © 2015 Travis Matthews. All rights reserved.
//

import Foundation

extension Session {
    
    func getSubredditPosts(name: String!, onCompletion: (Any) ->  ()) {
        let mySubreddit = RequestProperties(path: "/r/\(name)", httpMethod: .Get, params: nil)
        
        guard self.oauthToken != nil else {
            return
        }
        
        if let request: NSMutableURLRequest = oauthAuthenticatedRequest(mySubreddit) {
            let task = session.dataTaskWithRequest(request) { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
                let result = resultFromOptionalError(Response(data: data, urlResponse: response), optionalError: error)
                             .flatMap(acceptableStatusCode)
                             .flatMap(fromDataToJSON)
                             .flatMap(fromJSONToSubreddit)
                
                switch result {
                    
                case .Success(let val):
                    dispatch_async(dispatch_get_main_queue()) {
                        onCompletion(val)
                    }
                    
                case .Failure(let error):
                    NSLog("\(error)")
                }
            }
            
            task.resume()
        }
    }
}

