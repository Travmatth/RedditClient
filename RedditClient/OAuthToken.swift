//
//  OAuthToken.swift
//  RedditClient
//
//  Created by Travis Matthews on 11/15/15.
//  Copyright © 2015 Travis Matthews. All rights reserved.
//

import Foundation

struct OAuthToken {
    let accessToken: String!
    let tokenType: String!
    let expiresIn: Int!
    let refreshToken: String!
    let scope: String!
}
