//
//  Session+RedditPost.swift
//  RedditClient
//
//  Created by Travis Matthews on 12/22/15.
//  Copyright © 2015 Travis Matthews. All rights reserved.
//

import Foundation

extension Session {
    //Query API for a post on reddit; uses [IDENTIFIER?]
    func getRedditPost(post: PostData, onCompletion completion: (NSData) -> Void )  {
        //https://www.reddit.com/r/IAmA/comments/3xvxn1/hey_man_im_tommy_chong_12_of_cheech_chong/
        let path = "/r/\(post.subreddit)/comments/\(post.id)"
        let apiCallParams = RequestProperties(path: path, httpMethod: .Get, params: nil, paramsList: nil)
        
        guard self.user?.oauthToken != nil else { return }
        
        if let request: NSMutableURLRequest = oauthAuthenticatedRequest(apiCallParams) {
            let task = session.dataTaskWithRequest(request) { (data: NSData?, response: NSURLResponse?, error: NSError?) -> Void in
                let result = resultFromOptionalError(Response(data: data, urlResponse: response), optionalError: error).flatMap(acceptableStatusCode)
                switch result {
                case .Success(let data):
                    dispatch_async(dispatch_get_main_queue()) { completion(data)
                    }
                case .Failure(let error):
                    NSLog("\(error)")
                }
            }
            task.resume()
        }
    }
}