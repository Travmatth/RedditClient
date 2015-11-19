//
//  APIManager.swift
//  RedditClient
//
//  Created by Travis Matthews on 11/8/15.
//  Copyright © 2015 Travis Matthews. All rights reserved.
//

import Foundation
import UIKit
import SafariServices

class APIManager {
    
    // TODO: organize vars by function, move into code areas responsible; isolate constants; better names!
    //https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/intro_understanding_web_server_oauth_flow.htm 
    //https://en.wikipedia.org/wiki/Uniform_Resource_Identifier 
    
    // MARK: Essential Functions of APIManager
    let session = NSURLSession.sharedSession()
    var oauthToken: OAuthToken?
    let tokenRequestURL = "https://www.reddit.com/api/v1/access_token"
    let redirectURI = "travMatth://RedditClient"
    var apiUse: APIUsage?
    
    // MARK: API Calls
    func queryRedditAPI(url: NSMutableURLRequest, target: APITarget, completion: (results) -> ()) {
                /*
                class func mutableOAuthRequestWithBaseURL(baseURL:String, path:String, method:String, token:Token?) -> NSMutableURLRequest? {
                    guard let URL = NSURL(string:baseURL + path) else { return nil }
                    let URLRequest = NSMutableURLRequest(URL: URL)
                    URLRequest.setOAuth2Token(token)
                    URLRequest.HTTPMethod = method
                    URLRequest.setUserAgentForReddit()
                    return URLRequest
                }
                
                func setOAuth2Token(token:Token?) {
                    if let token = token {
                        setValue("bearer " + token.accessToken, forHTTPHeaderField:"Authorization")
                    }
                }
                
                */
        
        // MARK: OAuth request for access token
        let task = session.dataTaskWithRequest(request) { (data: NSData?, response: NSURLResponse?, error: NSError?)  -> Void in
            NSLog("response: \(response)\ndata:\n\(NSString(data: data!, encoding: NSUTF8StringEncoding))\nerror: \(error)")
            // let result = resultFromOptionalError(Response(data: data, urlResponse: response), optionalError:error)
            let result = resultFromOptionalError(Response(data: data, urlResponse: response), optionalError: error)
                .flatMap(acceptableStatusCode)
                .flatMap(fromDataToJSON)
                .flatMap({ (json: Any) -> Result<Any> in
                    if let json = json as? Dictionary<String, AnyObject> { return Result(value: json) }
                    else { return Result(error: "failed to parse json") }
                })
            
            switch result {
                
            case .Success(let object):
                self.oauthToken = OAuthToken(accessToken, tokenType, expiresIn, refreshToken, scopes)
                self.oauthToken?.save()
                
                NSLog("token:\n\(self.oauthToken)")
                
            case .Failure(let error): NSLog(error)
            }
                    
            //NSLog("Result:\n\(result)")
            /*
            token parsed into json
            {
                "access_token" = "46882130-3z9H1TRuyJRYVKa_4igrZkjSApQ";
                "expires_in" = 3600;
                "refresh_token" = "46882130-sAxNLtbvky0EYxWQn6BlJOUhzZY";
                scope = read;
                "token_type" = bearer;
            }
            */
            
            // Need to parse response and grab token to store
        }
        
        task.resume()
    }
}
