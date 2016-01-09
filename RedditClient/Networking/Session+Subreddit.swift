//
//  Session+Subreddit.swift
//  RedditClient
//
//  Created by Travis Matthews on 11/26/15.
//  Copyright © 2015 Travis Matthews. All rights reserved.
//

import Foundation

protocol NetworkCommunication {
    weak var session: Session! { get }
}

extension Session {
    
    func getSubredditPosts(path: String?, onCompletion: (LinkListing?) ->  Void) {
        let mySubreddit: RequestProperties
        if let path = path {
            mySubreddit = RequestProperties(path: "/r/" + path, httpMethod: .Get, params: nil, paramsList: nil)
        } else {
            mySubreddit = RequestProperties(path: "", httpMethod: .Get, params: nil, paramsList: nil)
        }
 
        guard self.user?.oauthToken != nil else {
            return
        }
        
        if let request: NSMutableURLRequest = oauthAuthenticatedRequest(mySubreddit) {
            let task = session.dataTaskWithRequest(request) { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
                let result = resultFromOptionalError(Response(data: data, urlResponse: response), optionalError: error)
                             .flatMap(acceptableStatusCode)
                
                switch result {
                    
                case .Success(let jsonData):
                    let linkListing = LinkListing(fromData: jsonData)
                    dispatch_async(dispatch_get_main_queue()) {
                        onCompletion(linkListing)
                    }
                case .Failure(let error):
                    NSLog("\(error)")
                }
            }
            task.resume()
        }
    }
}

/*$ find . "(" -name "*.swift"  ")" -print0 | xargs -0 wc -l
 * count number of lines in project
 *
 */