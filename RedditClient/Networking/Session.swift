//
//  Session.swift
//  RedditClient
//
//  Created by Travis Matthews on 11/8/15.
//  Copyright © 2015 Travis Matthews. All rights reserved.
//

import Foundation
import UIKit
import SafariServices

class Session {
    
    // TODO: organize vars by function, move into code areas responsible; isolate constants; better names!
    //https://developer.salesforce.com/docs/atlas.en-us.api_rest.meta/api_rest/intro_understanding_web_server_oauth_flow.htm 
    //https://en.wikipedia.org/wiki/Uniform_Resource_Identifier 
    
    // Singleton
    static let sharedInstance = Session()
    private init() {}
    
    // MARK: Essential Functions of Session
    let session = NSURLSession.sharedSession()
    var apiUse: APIUsage?
    var user: User?
    
    // MARK: Constants to pull out?
    let redirectURI = "travMatth://RedditClient"
    let oauthAuthenticatedRequestUrl = "https://oauth.reddit.com"
    let tokenRequestUrl = "https://www.reddit.com/api/v1/access_token"
    
    // MARK: API Calls
    func oauthAuthenticatedRequest(target: RequestProperties) -> NSMutableURLRequest? {
        guard user != nil && user!.oauthToken != nil else { return nil }
        
        let fullUrl: NSURL = NSURL(string: oauthAuthenticatedRequestUrl + target.path)!
        let request = NSMutableURLRequest(URL: fullUrl)
        if target.params != nil { request.HTTPBody = target.httpParams }
        request.setValue("Bearer \(user!.oauthToken!.accessToken)", forHTTPHeaderField: "Authorization")
        
        return request
    }
}