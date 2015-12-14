//
//  Erros.swift
//  RedditClient
//
//  Created by Travis Matthews on 11/29/15.
//  Copyright © 2015 Travis Matthews. All rights reserved.
//

import Foundation

public enum RedditClientError: ErrorType {
    case StackError(String)
    
    enum Recommendations: ErrorType {
        case UserHasNoKarma
    }
    
    enum ListingError: ErrorType {
        case TreeWithIdentifierNotFound
    }
    
    enum ParsingError: ErrorType {
        case FailedDictionaryCast
        case FailedArrayCast
        case FailedJsonConversion
        case FailedDictLookup
        case FailedCastFromDictKeyToArray
        case FailedNestedDictionaryRetrievalWithKey(key: String)
        case FailedToParseJson
        case FailedArrayLookup
        case FailedToParseJsonTag
    }
    
    enum NetworkError: ErrorType {
        case StatusCodeOutOfRange(code: String?)
        case FailedAccessTokenRequest
    }
}