//
//  Session+Recommendations.swift
//  RedditClient
//
//  Created by Travis Matthews on 11/27/15.
//  Copyright © 2015 Travis Matthews. All rights reserved.
//

import Foundation

extension Session {
    // Needs to query api for recommendations against a reddit, return list of recommendations
    func addRecommendations(seed: Recommendation, completed: Bool, onCompletion: ([Recommendation]) -> Void) {
        let recommendationRequestProperties = RequestProperties(path: "/api/recommend/sr/\(seed)", httpMethod: .Get, params: nil, paramsList: nil)
        
        if let recommendationRequest: NSMutableURLRequest = oauthAuthenticatedRequest(recommendationRequestProperties) {
            let task = session.dataTaskWithRequest(recommendationRequest) { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
                let result = resultFromOptionalError(Response(data: data, urlResponse: response), optionalError: error)
                             .flatMap(acceptableStatusCode)
                             .flatMap(fromDataToJSON)
                             .flatMap(fromJSONToSubredditRecommendations)
                
                switch result {
                    
                case .Success(let subs):
                    dispatch_async(dispatch_get_main_queue()) {
                        let subs = subs as! [String]
                        onCompletion(subs)
                        if completed { NSNotificationCenter.defaultCenter().postNotificationName("RecommendationsReady", object: nil) }
                    }
                    
                case .Failure(let error):
                    NSLog("\(error)")
                }
            }
            task.resume()
        }
        
    }
    
    func seedsForRecommendations(onCompletion: ([Recommendation]) -> Void) {
        var recommendations: [String] = []
        
        getUsernameKarma() { (karmaBreakdown) -> Void in
            for subreddit in karmaBreakdown {
                recommendations.append(subreddit.subreddit)
            }
            onCompletion(recommendations)
        }
    }
    
    func getUsernameKarma(onCompletion: ([Karma]) -> Void) {
        let myUsernameRequestTarget = RequestProperties(path: "/api/v1/me/karma", httpMethod: .Get, params: nil, paramsList: nil)
        
        if let myUsernameRequest: NSMutableURLRequest = oauthAuthenticatedRequest(myUsernameRequestTarget) {
            let task = session.dataTaskWithRequest(myUsernameRequest) { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
                let result = resultFromOptionalError(Response(data: data, urlResponse: response), optionalError: error)
                             .flatMap(acceptableStatusCode)
                             .flatMap(fromDataToJSON)
                             .flatMap(fromJSONToKarmaBreakdown)
                
                switch result {
                case .Success(let data):
                    dispatch_async(dispatch_get_main_queue()) {
                        let data = data as! [Karma]
                        onCompletion(data)
                    }
                case .Failure(let error):
                    NSLog("\(error)")
                }
            }
            task.resume()
        }
    }
}