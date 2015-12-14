//
//  OAuthToken.swift
//  RedditClient
//
//  Created by Travis Matthews on 11/15/15.
//  Copyright © 2015 Travis Matthews. All rights reserved.
//

import Foundation

//https://developer.apple.com/library/prerelease/ios/referencelibrary/GettingStarted/DevelopiOSAppsSwift/Lesson10.html 
class OAuthToken {
    
    let defaults = NSUserDefaults.standardUserDefaults()
    
    let expiresIn: Int
    let scopes: String
    let tokenType: String
    let accessToken: String
    let refreshToken: String
    
    init(_ accessToken: String?, _ tokenType: String?, _ expiresIn: Int?, _ refreshToken: String?, _ scopes: String?) {
        self.scopes = scopes ?? ""
        self.expiresIn = expiresIn ?? 0
        self.tokenType = tokenType ?? ""
        self.accessToken = accessToken ?? ""
        self.refreshToken = refreshToken ?? ""
    }
    
    
    init(json: Dictionary<String, AnyObject>?) {
        accessToken = json?["access_token"] as? String ?? ""
        expiresIn = json?["expires_in"] as? Int ?? 0
        refreshToken = json?["refresh_token"] as? String ?? ""
        scopes =  json?["scope"] as? String ?? ""
        tokenType = json?["token_type"] as? String ?? ""
    }
    
    init() {
        
        self.scopes = ""
        self.tokenType = ""
        self.accessToken = ""
        self.expiresIn = 0
        self.refreshToken = ""
    }
    
}
