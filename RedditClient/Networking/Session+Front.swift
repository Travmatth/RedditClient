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