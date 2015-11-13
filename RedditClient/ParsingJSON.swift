//
//  ParsingJSON.swift
//  RedditClient
//
//  Created by Travis Matthews on 11/11/15.
//  Copyright © 2015 Travis Matthews. All rights reserved.
//

import Foundation

//typealias JSON = AnyObject
//typealias JSONDictionary = Dictionary<String, JSON>
//typealias JSONArray = Array<JSON>

// Code handle errors by introducing the first functional programming concept, the Either<A, B> type. This will let us return the user object when everything runs smoothly or an error when it doesn't. 
enum Either<A,B> {
    case Left(A)
    case Right(B)
}