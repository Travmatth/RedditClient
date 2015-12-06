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
    func addRecommendation(seed: Recommendation, onCompletion: ([Recommendation]) -> Void) {
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
                        //NSNotificationCenter.defaultCenter().postNotificationName("NewRecommendation", object: nil)
                    }
                    
                case .Failure(let error):
                    NSLog("\(error)")
                }
            }
            task.resume()
        }
    }
    
    func addRecommendations(seeds: [Recommendation], onCompletion: ([Recommendation]) -> Void) {
        // Hack-ey; if making recommendation request with multiple subreddits, high chance of null response so here making requests individually
        var recommendations: [Recommendation] = []
        let offset: Int = 2 // want to stop at 2nd to last element in seeds array
        for i in 0 ..< seeds.count - offset {
            addRecommendation(seeds[i]) { newRecommendations -> Void in
                recommendations += newRecommendations
                NSNotificationCenter.defaultCenter().postNotificationName("NewRecommendations", object: nil)
            }
        }
        addRecommendation(seeds[seeds.count - 1]) { newRecommendations -> Void in
            recommendations += newRecommendations
            onCompletion(recommendations)
            NSNotificationCenter.defaultCenter().postNotificationName("NewRecommendations", object: nil)
        }
    }
    
    func seedsForRecommendations(onCompletion: ([Recommendation]) -> Void) {
        getUsernameKarma() { karmaBreakdown -> Void in
            onCompletion( karmaBreakdown.map({ $0.0 }) )
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