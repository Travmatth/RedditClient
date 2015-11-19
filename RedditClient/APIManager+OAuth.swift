//
//  APIManager+OAuth.swift
//  RedditClient
//
//  Created by Travis Matthews on 11/19/15.
//  Copyright © 2015 Travis Matthews. All rights reserved.
//

import Foundation
import SafariServices

protocol OAuthFlow {
    
    //Finish fleshing out requirements of OAuthProtocol
    func startOAuthFlow() -> SFSafariViewController
    func login(url: NSURL)
    
    
    // Cant declare stored property in extension; will write method to pull from plist as is needed
    // var scopes: String { get }
    
}

extension APIManager: OAuthFlow {
    
    //let username = "another_test_acct"
    //let password = "thisisntatest"
    //let headers = [ "user-agent": "/u/another_test_acct reddit client app"]
    
    func startOAuthFlow() -> SFSafariViewController {
        
    let scopes = "read,identity,edit,flair,history,mysubreddits,privatemessages,report,save,submit,subscribe,vote,wikiedit,wikiread"
    
        let url: NSURL = NSURL(string: "https://ssl.reddit.com/api/v1/authorize.compact?client_id=eDGbSVLzgyozTA&response_type=code&state=TEST&redirect_uri=travMatth://RedditClient&duration=permanent&scope=\(scopes)")!
        
        let authorizationPage: SFSafariViewController = SFSafariViewController(URL: url)
        
        return authorizationPage
    }
    
    // TODO: Continue refactoring
    /*
        Step 2 of the OAuth Flow: token retrieval (code) flow
        pull params back into func, better names
        break into own protocol & extension?
    */
    func login(url: NSURL) {
        
        // Parse return URL
        var code: String!
        let responseUrl = NSURLComponents(URL: url, resolvingAgainstBaseURL: false)
        NSLog(responseUrl!.string!)
        
        if responseUrl!.scheme! == "travmatth" {
            let params: [NSURLQueryItem]! = responseUrl!.queryItems
            code = params.last?.value
        }
        
        NSLog("code: \(code)")
        
        // Post access token request
        
        // for basic auth, header title == Authorization
        // header body = "basic " + "username:password" encoded in base64
        // username = clientID; password == "" for reddit api
        
        let clientId = "eDGbSVLzgyozTA:".dataUsingEncoding(NSUTF8StringEncoding)!
        let clientIdEncoded = clientId.base64EncodedStringWithOptions(.Encoding64CharacterLineLength)
        
        
        let url = NSURL(string: tokenRequestURL)!
        
        let request = NSMutableURLRequest(URL: url)
        
        request.HTTPMethod = "POST"
        request.setValue("Basic " + clientIdEncoded, forHTTPHeaderField: "Authorization")
        
        let httpParams = "grant_type=authorization_code&code=\(code)&redirect_uri=\(redirectURI)"
        let data = httpParams.dataUsingEncoding(NSUTF8StringEncoding)
        request.HTTPBody = data
        
        
        NSLog("clientID: \(clientIdEncoded)")


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
                // MARK: receiving OAuth access token
                // TODO: pull into own class / func / should probably throw error if parse fails, start guest code flow
                let temp = object as! Dictionary<String, AnyObject>
                
                NSLog("temp:\n\(temp)")
                
                // if temp[invalidrequest]; abort
                let accessToken = temp["access_token"] as! String
                let expiresIn = temp["expires_in"] as! Int
                let refreshToken = temp["refresh_token"] as! String
                let scopes =  temp["scope"] as! String
                let tokenType = temp["token_type"] as! String
                
                //self.responseToken = OAuthToken(accessToken, tokenType, expiresIn, refreshToken, scope)
                self.oauthToken = OAuthToken(accessToken, tokenType, expiresIn, refreshToken, scopes)
                //self.oauthToken.save()
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