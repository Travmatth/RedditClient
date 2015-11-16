//
//  APIManager.swift
//  RedditClient
//
//  Created by Travis Matthews on 11/8/15.
//  Copyright © 2015 Travis Matthews. All rights reserved.
//

import Foundation
import UIKit

class APIManager {
    
    let session = NSURLSession.sharedSession()
    
    let tokenRequestURL = "https://www.reddit.com/api/v1/access_token"
    let redirectURI = "travMatth://RedditClient"
    
    let username = "another_test_acct"
    let password = "thisisntatest"
    let headers = [ "user-agent": "/u/another_test_acct reddit client app"]
    
    var responseUrl: NSURLComponents!
    var params: [NSURLQueryItem]!
    var state: String!
    var code: String!
    
    // holds current modHash for requests, needs to persist across instances
    static var modHash = ""
    
    var cookie: String?
    var url: NSURL?
    
    var responseToken: OAuthToken!
    
    func login(url: NSURL) {
        // Parse return URL
        let responseUrl = NSURLComponents(URL: url, resolvingAgainstBaseURL: false)
        NSLog(responseUrl!.string!)
        
        if responseUrl!.scheme! == "travmatth" {
            params = responseUrl!.queryItems
            state = params.first?.value
            code = params.last?.value
        }
        NSLog("state: \(state); code: \(code)")
        
        // Post access token request
        
        // for basic auth, header title == Authorization
        // header body = "basic " + "username:password" encoded in base64
        // username = clientID; password == "" for reddit api
        
        
        let client_id = "eDGbSVLzgyozTA:".dataUsingEncoding(NSUTF8StringEncoding)!.base64EncodedDataWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)
        
        let httpParams = "grant_type=authorization_code&code=" + code + "&redirect_uri=" + redirectURI
        
        let url = tokenRequestURL
        
        let request = NSMutableURLRequest(URL: NSURL(string: url)!)
        
        let data = httpParams.dataUsingEncoding(NSUTF8StringEncoding)
        
        request.setValue("Basic " + client_id, forHTTPHeaderField: "Authorization")
        request.HTTPBody = data
        request.HTTPMethod = "POST"
        
        let task = session.dataTaskWithRequest(request) { (data: NSData?, response: NSURLResponse?, error: NSError?)  -> Void in
            NSLog("response: \(response)\nerror: \(error)")
            // let result = resultFromOptionalError(Response(data: data, urlResponse: response), optionalError:error)
            let result = resultFromOptionalError(Response(data: data, urlResponse: response), optionalError: error)
                .flatMap(acceptableStatusCode)
                .flatMap(fromDataToJSON)
                .flatMap({ (json: Any) -> Result<Any> in
                    if let json = json as? Dictionary<String, AnyObject> {
                        return Result(value: json)
                    }
                    else { return Result(error: "failed to parse json") }
                })
            
            switch result {
                
            case .Success(let object):
                let temp = object as! Dictionary<String, AnyObject>
                
                let accessToken = temp["access_token"] as! String
                let expiresIn = temp["expires_in"] as! Int
                let refreshToken = temp["refresh_token"] as! String
                let scope = temp["scope"] as! String
                let tokenType = temp["token_type"] as! String
                
                self.responseToken = OAuthToken(accessToken: accessToken,  tokenType: tokenType, expiresIn: expiresIn, refreshToken: refreshToken, scope: scope)
                NSLog("token:\n\(self.responseToken)")
                
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