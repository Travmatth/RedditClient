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
    
    init(_ accessToken: String, _ tokenType: String, _ expiresIn: Int, _ refreshToken: String, _ scopes: String) {
        
        self.scopes = scopes
        self.expiresIn = expiresIn
        self.tokenType = tokenType
        self.accessToken = accessToken
        self.refreshToken = refreshToken
    }
    
    init() {
        
        self.scopes = defaults.stringForKey("scopes")!
        self.tokenType = defaults.stringForKey("tokenType")!
        self.accessToken = defaults.stringForKey("accessToken")!
        self.expiresIn = Int(defaults.stringForKey("expiresIn")!)!
        self.refreshToken = defaults.stringForKey("refreshToken")!
    }
    
    func save() {
        
        defaults.setValue(scopes, forKey: "scopes")
        defaults.setValue(tokenType, forKey: "tokenType")
        defaults.setValue(expiresIn, forKey: "expiresIn")
        defaults.setValue(accessToken, forKey: "accessToken")
        defaults.setValue(refreshToken, forKey: "refreshToken")
    }
}
