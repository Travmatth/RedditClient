//
//  ParseListing.swift
//  RedditClient
//
//  Created by Travis Matthews on 12/6/15.
//  Copyright © 2015 Travis Matthews. All rights reserved.
//

import Foundation

/*
  Accept data from networking; split into head and tails
    Head: Posts data item
    Tail: Recursively
*/



enum Parse {
    
    init(withJson json: AnyObject) {
        self = .Unknown(json)
    }
    
    //MARK: Public cases
    case Post(info: PostData)
    case Listing(replies: [[String: AnyObject]])
    case Comment(comment: CommentData, replies: [[String: AnyObject]])
    case More(more: MoreReplies)
    
    //MARK: Internal cases
    case Error(ErrorType)
    case JsonDictionary([String: AnyObject])
    case JsonArray([AnyObject])
    case Unknown(AnyObject)
    
    //MARK: private enum used in parsing json object
    private enum TypePrefix: String {
        case Comment = "t1"
        case Account = "t2"
        case Link = "t3"
        case Message = "t4"
        case Subreddit = "t5"
        case Award = "t6"
        case PromoCampaign = "t8"
        case Listing = "Listing"
        case More = "more"
        case Null = ""
    }
    
    //MARK: main parsing method
    var resultType: Parse {
        switch self {
        case .Unknown:
            
            let tag = self.toJsonDictionary.retrieveKey("kind")
            let type = TypePrefix(rawValue: tag)
            
            if type == nil { return .Error(RedditClientError.ParsingError.FailedToParseJson) }
            if type?.rawValue == "" {
                return .Error(RedditClientError.ParsingError.FailedToParseJson)
            }
            
            //fatalError("design decision: let classes handle own json scraping, minimize code in parse enum")
            switch type! {
            case .Listing:
                let replies = self.toJsonDictionary.retrieveNestedDictionaryWithKey("data").retrieveNestedArrayWithKey("children").toArrayOfDictionaries
                return .Listing(replies: replies)
            case .Comment:
                let data = CommentData(withJson: self.toJsonDictionary.toDictionary)
                /* Drill down into json and extract replies */
                let replies = self.toJsonDictionary
                    .retrieveNestedDictionaryWithKey("data")
                    .retrieveNestedDictionaryWithKey("replies")
                    .retrieveNestedDictionaryWithKey("data")
                    .retrieveNestedArrayWithKey("children")
                    .toArrayOfDictionaries
                
                return .Comment(comment: data, replies: replies)
            case .Link:
                return .Post(info: PostData(withJson: self.toDictionary))
            case .More:
                return .More(more: MoreReplies(json: self.toJsonDictionary.toDictionary))
            default:
                return .Error(RedditClientError.ParsingError.FailedToParseJson)
            }
        default: return .Error(RedditClientError.ParsingError.FailedToParseJson)
        }
    }
    
    //MARK: Navigating Json
    var toDictionary: [String: AnyObject] {
        switch self {
        case .JsonDictionary(let success): return success
        default: return [:]
        }
    }
    
    var toArrayOfDictionaries: [[String: AnyObject]] {
        switch self {
        case .JsonArray(let seq):
            var _temp: [[String: AnyObject]] = []
            for element in seq {
                if let element = element as? [String: AnyObject] {
                    _temp.append(element)
                }
            }
            return _temp
        default: return []
        }
    }
    
    var toJsonDictionary: Parse {
        switch self {
        case .JsonDictionary/*(let dictionary)*/:
            return self
        case .Unknown(let json):
            if let success = json as? [String: AnyObject] {
                return .JsonDictionary(success)
            }
            fallthrough
        default:
            return .Error(RedditClientError.ParsingError.FailedDictionaryCast)
        }
    }
    
    var toJsonArray: Parse {
        switch self {
        case .JsonArray/*(let dictionary)*/: return self
        case .Unknown(let json):
            if let success = json as? [AnyObject] {
                return .JsonArray(success)
            }
            fallthrough
        default: return .Error(RedditClientError.ParsingError.FailedArrayCast)
        }
    }
    
    func valueExistsInDictionary(value: String) -> Parse {
        switch self {
        case .JsonDictionary(let dict):
            if let _ = dict[value] {
                return self
            }
            fallthrough
        default: return .Error(RedditClientError.ParsingError.FailedDictLookup)
        }
    }
    
    func retrieveKey(key: String) -> String {
        switch self {
        case .JsonDictionary(let dict):
            if let success = dict[key] as? String {
                return success
            }
            fallthrough
        default: return ""
        }
    }
    
    func retrieveNestedDictionaryWithKey(value: String) -> Parse {
        switch self {
        case .JsonDictionary(let dict):
            if let success = dict[value] as? [String: AnyObject] {
                return .JsonDictionary(success)
            }
            else {
                return .JsonDictionary([:])
            }
        default:
            return .Error(RedditClientError.ParsingError.FailedNestedDictionaryRetrievalWithKey(key: value))
        }
    }
    
    func retrieveNestedArrayWithKey(value: String) -> Parse {
        switch self {
        case .JsonDictionary(let dict):
            if let success = dict[value] as? [AnyObject] {
                return .JsonArray(success)
            }
            else {
                return .JsonArray([])
            }
        default:
            return .Error(RedditClientError.ParsingError.FailedNestedDictionaryRetrievalWithKey(key: value))
        }
    }
    
    func retrieveDictionaryAtArrayIndex(value: Int) -> Parse {
        switch self {
        case .Unknown(let seq):
            if let success = seq[value] as? [String: AnyObject] {
                return .JsonDictionary(success)
            }
            fallthrough
        default:
            return .Error(RedditClientError.ParsingError.FailedArrayLookup)
        }
    }
}