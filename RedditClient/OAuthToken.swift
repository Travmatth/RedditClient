//
//  OAuthToken.swift
//  RedditClient
//
//  Created by Travis Matthews on 11/15/15.
//  Copyright © 2015 Travis Matthews. All rights reserved.
//

import Foundation

//https://developer.apple.com/library/prerelease/ios/referencelibrary/GettingStarted/DevelopiOSAppsSwift/Lesson10.html 
struct OAuthToken {
    
    let accessToken: String
    let tokenType: String
    let expiresIn: Int
    let refreshToken: String
    let scopes: [String]
    
    init(_ accessToken: String, _ tokenType: String, _ expiresIn: Int, _ refreshToken: String, _ scopes: [String]) {
        self.accessToken = accessToken
        self.tokenType = tokenType
        self.expiresIn = expiresIn
        self.refreshToken = refreshToken
        self.scopes = scopes
    }
    
    func save() {
        
    }
    
}
