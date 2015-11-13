//
//  NSError+errorWithCode.swift
//  RedditClient
//
//  Created by Travis Matthews on 11/12/15.
//  Copyright © 2015 Travis Matthews. All rights reserved.
//

import Foundation

extension NSError {
    class func errorWithCode(code: Int, _ description: String) -> NSError {
        return NSError(domain: "com.TravMatt.RedditClient", code: 42, userInfo: ["this": "that"])
    }
}