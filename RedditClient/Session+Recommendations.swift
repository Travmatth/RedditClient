//
//  Session+Recommendations.swift
//  RedditClient
//
//  Created by Travis Matthews on 11/27/15.
//  Copyright © 2015 Travis Matthews. All rights reserved.
//

import Foundation

extension Session {
    
    func getRecommendations(onCompletion: (recommendations: [String]) -> Void) {
        throw fatalError("need to finish fleshing out recommendations, getSubmittedPosts not currently working? ")
        NSLog("getRecommendations called")
        var recommendations: [String]
        /* Recommendations makes 4! api calls
        1: who is current user?
        2: get submitted posts
        3: get submitted comments
        4: get upvoted comments
        
        GET /user/username/wherehistory
        → /user/username/submitted
        → /user/username/comments
        → /user/username/upvoted
        → /user/username/downvoted
        */
        
        // 1: current user
        if user == nil {
            getUsername() { (user) -> Void in
                self.user = user
            }
        }
        
        // 2: get submitted posts
        var posts: [Post] = []
        getSubmittedPosts() { (posts) -> Void in
            NSLog("completed")
        }
        
    }
    
    func getSubmittedPosts(onCompletion: (Any) -> Void) {
        NSLog("getSubmittedPosts called")
        let params: [String: String] = ["limit": "100", "sr_detail": "true", "show": "given", "sort": "new"]
        //TODO: Testing with random user
        //let myUsernameRequestTarget = RequestProperties(path: "/\(user)/submitted", httpMethod: .Get, params: params)
        let myUsernameRequestTarget = RequestProperties(path: "/dxmzan/submitted", httpMethod: .Get, params: params)
        if let myUsernameRequest: NSMutableURLRequest = oauthAuthenticatedRequest(myUsernameRequestTarget) {
            
            let task = session.dataTaskWithRequest(myUsernameRequest) { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
                let result = resultFromOptionalError(Response(data: data, urlResponse: response), optionalError: error)
                             .flatMap(acceptableStatusCode)
                             .flatMap(fromDataToJSON)
                             .flatMap(fromJSONToPosts)
                
                switch result {
                    
                case .Success(let posts):
                    dispatch_async(dispatch_get_main_queue()) {
                        //let posts = posts as! [Post]
                        onCompletion(posts)
                        NSLog("success!")
                    }
                    
                case .Failure(let error):
                    NSLog("\(error)")
                }
            }
        
            task.resume()
        }
    }
    
    func getUsername(onCompletion: (String) -> Void) {
        let myUsernameRequestTarget = RequestProperties(path: "/api/v1/me", httpMethod: .Get, params: nil)
        if let myUsernameRequest: NSMutableURLRequest = oauthAuthenticatedRequest(myUsernameRequestTarget) {
            
            let task = session.dataTaskWithRequest(myUsernameRequest) { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
                let result = resultFromOptionalError(Response(data: data, urlResponse: response), optionalError: error)
                             .flatMap(acceptableStatusCode)
                             .flatMap(fromDataToJSON)
                             .flatMap(fromJSONToUser)
                
                switch result {
                    
                case .Success(let user):
                    dispatch_async(dispatch_get_main_queue()) {
                        NSLog("user: \(self.user)")
                        let name = user as! String
                        onCompletion(name)
                    }
                    
                case .Failure(let error):
                    NSLog("\(error)")
                }
            }
        
            task.resume()
        }
    }
}