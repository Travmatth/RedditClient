//
//  Session+Multi.swift
//  RedditClient
//
//  Created by Travis Matthews on 11/21/15.
//  Copyright © 2015 Travis Matthews. All rights reserved.
//

import Foundation

extension Session {
    
    func getMultiReddits(onCompletion: (Any) ->  ()) {
        let myMulti = RequestProperties(path: "/api/multi/mine", httpMethod:  .Get, params: ["expand_srs": "true"], paramsList: nil)
        guard self.oauthToken != nil else {
            return
        }
        if let request: NSMutableURLRequest = oauthAuthenticatedRequest(myMulti) {
            let task = session.dataTaskWithRequest(request) { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
                let result = resultFromOptionalError(Response(data: data, urlResponse: response), optionalError: error)
                             .flatMap(acceptableStatusCode)
                             .flatMap(fromDataToJSONArray)
                             .flatMap(fromJSONToMulti)
                
                switch result {
                    
                case .Success(let val):
                    dispatch_async(dispatch_get_main_queue()) { onCompletion(val) }
                    
                case .Failure(let error):
                    NSLog("\(error)")
                }
            }
            task.resume()
        }
    }
}