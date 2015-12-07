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
}