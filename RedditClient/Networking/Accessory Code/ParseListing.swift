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

class RedditPost {
    //MARK: Class variables
    let post: PostData?
    let comments: CommentTree?
    
    //MARK: Class lifecycle
    init?(dataFromNetworking data: NSData) {
        var json: Array<Any>
        var head: [String: AnyObject]
        var tail: [String: AnyObject]
        
        do {
            json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as! Array<AnyObject>
            head = json[0] as? [String: AnyObject] ?? [:]
            tail = json[1] as? [String: AnyObject] ?? [:]
        } catch {
            post = nil
            comments = nil
            return nil
        }
        post = PostData(json: head)
        comments = CommentTree(json: tail)
    }
}

enum ListingParse {
    
    case Error(ErrorType)
    case JsonDictionary([String: AnyObject])
    case JsonArray([AnyObject])
    case Unknown(AnyObject)
    
    init(value: AnyObject) {
        self = .Unknown(value)
    }
    
    var toJsonDictionary: ListingParse {
        switch self {
        case .JsonDictionary/*(let dictionary)*/: return self
        case .Unknown(let json):
            if let success = json as? [String: AnyObject] {
                return .JsonDictionary(success)
            }
            fallthrough
        default: return .Error(RedditClientError.ParsingError.FailedDictionaryCast)
        }
    }
    
    var toJsonArray: ListingParse {
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
    
    func ifArray(value: AnyObject) -> ListingParse {
        if let success = value as? [String] {
            return .JsonArray(success)
        }
        return .Error(RedditClientError.ParsingError.FailedArrayCast)
    }
    
    func valueExistsInDictionary(value: String) -> ListingParse {
        switch self {
        case .JsonDictionary(let dict):
            if let _ = dict[value] {
                return self
            }
            fallthrough
        default: return .Error(RedditClientError.ParsingError.FailedDictLookup)
        }
    }
    
    func transformDictKeyToArray(value: String) -> ListingParse {
        switch self {
        case .JsonDictionary(let dict):
            if let success = dict[value] as? Array<AnyObject> {
                return .JsonArray((success))
            }
            fallthrough
        default: return .Error(RedditClientError.ParsingError.FailedCastFromDictKeyToArray)
        }
    }
    
    func jsonInDictIsOfKind(kind: TypePrefix) -> Bool {
        switch self {
        case .JsonDictionary(let dict):
            if let test = TypePrefix(rawValue: dict["kind"] as? String ?? "") {
                if test.rawValue == kind.rawValue {
                    return true
                }
            }
            fallthrough
        default: return false
        }
    }
    
    var toDictionary: [String: AnyObject]? {
        switch self {
        case .JsonDictionary(let dict): return dict
        default: return nil
        }
    }
    
    var toArray: [AnyObject]? {
        switch self {
        case .JsonArray(let seq): return seq
        default: return nil
        }
    }
    
    func retrieveNestedDictWithKey(value: String) -> ListingParse {
        switch self {
        case .JsonDictionary(let dict):
            if let success = dict[value] as? [String: AnyObject] {
                return .JsonDictionary(success)
            }
            fallthrough
        default: return .Error(RedditClientError.ParsingError.FailedNestedDictionaryRetrievalWithKey(key: value))
        }
    }
    
    func retrieveNestedArrayWithKey(value: String) -> ListingParse {
        switch self {
        case .JsonDictionary(let dict):
            if let success = dict[value] as? [AnyObject] {
                return .JsonArray(success)
            }
            fallthrough
        default: return .Error(RedditClientError.ParsingError.FailedNestedDictionaryRetrievalWithKey(key: value))
        }
    }
    
    //MARK: Json Parsing
    var getListing: ListingParse {
        return self.toJsonDictionary.valueExistsInDictionary("kind").retrieveNestedDictWithKey("data").retrieveNestedArrayWithKey("children")
    }
}


class CommentTree {
    var tree: Tree<CommentData>?
    
    init?(json: [String: AnyObject]) {
        if let tree = initTreeWithJson(json) {
            self.tree = tree
            return
        }
        return nil
    }
    
    /* A Depth First Traversal of the prospective comment tree */
    func initTreeWithJson(json: [String: AnyObject]) -> Tree<CommentData>? {
        
        var closed: Set<Tree<CommentData>> = []
        let tree : Tree<CommentData> = Tree<CommentData>()
        let listing = ListingParse(value: json).getListing
        typealias Stage = (tree: Tree<CommentData>, listing: ListingParse)
        let open: Stack<Stage> = Stack<Stage>()
        
        /* I need to split the json into init array; add to tree as children */
        let current = Stage(tree, listing)
        open.push(current)
        
        fatalError("NeedToImplement!")
        /*
        var topLevelComments: [[String: AnyObject]]
        
        for child in topLevelComments {
            tree.addChild(Tree<CommentData>(withJson: child)
        }
        
        open.push(tree)
        while !open.isEmpty {
            var current = open.pop!
            closed.insert(current)
            while current.hasUnprocessed
        }
        /* Add comment listings to tree */
        case .Listing(let modhash: String, let children: [CommentData], let before: String, let after: String):
            
            
            /* Add replies to children of self */
            //case .Comment:
            /* Post */
        }
        
        return tree
    }
    */
    
}
}

class PostDataFromJson {
    
    init?(json: [String: AnyObject]) {
        let kind = TypePrefix(rawValue: json["kind"] as? String ?? "")
        if kind == nil { return nil }
        switch kind! {
        case .Listing:
            if let listingData = (json["data"] as? [String: AnyObject] ?? [:])["children"] {
                // returned
                if let type = TypePrefix(rawValue: (listingData[0] as? [String: AnyObject] ?? [:])["kind"] as? String ?? "") {
                    switch type {
                    case .Link:
                        if let postData = (listingData[0] as? [String: AnyObject] ?? [:] )["data"] {
                            member = postData as? [String: AnyObject] ?? [:]
                        }
                    default: return nil
                    }
                }
            }
        default: return nil
        }
    }
    var member: [String: AnyObject] = [:]
}


func == (lhs: PostData, rhs: PostData) -> Bool { return lhs.id == rhs.id }

struct PostData {
    init?(json: [String: AnyObject]) {
        guard let data = PostDataFromJson(json: json) else {
            return nil
        }

        id =  data.member["id"] as? String ?? ""
        url =  data.member["url"] as? String ?? ""
        name =  data.member["name"] as? String ?? ""
        likes =  data.member["likes"] as? String ?? ""
        title =  data.member["title"] as? String ?? ""
        fromId =  data.member["from_id "] as? String ?? ""
        domain =  data.member["domain"] as? String ?? ""
        author =  data.member["author"] as? String ?? ""
        postHint =  data.member["post_hint"] as? String ?? ""
        selfText =  data.member["self_text"] as? String ?? ""
        permalink =  data.member["permalink"] as? String ?? ""
        thumbnail =  data.member["thumbnail"] as? String ?? ""
        subreddit =  data.member["subreddit"] as? String ?? ""
        subredditId =  data.member["subreddit_id"] as? String ?? ""
        selfTextHtml =  data.member["self_text_html"] as? String ?? ""
        linkFlairText =  data.member["link_flair_text"] as? String ?? ""
        authorFlairText =  data.member["author_flair_text"] as? String ?? ""
        linkFlairCssClass =  data.member["link_flair_css_class"] as? String ?? ""
        authorFlairCssClass =  data.member["author_flair_css_class"] as? String ?? ""

        nsfw =  data.member["over_18"] as? Bool ?? false
        saved =  data.member["saved"] as? Bool ?? false
        locked =  data.member["locked "] as? Bool ?? false
        isSelf =  data.member["isSelf "] as? Bool ?? false
        hidden =  data.member["hidden "] as? Bool ?? false
        edited =  data.member["edited "] as? Bool ?? false
        clicked =  data.member["clicked "] as? Bool ?? false
        visited =  data.member["visited "] as? Bool ?? false
        archived =  data.member["archived "] as? Bool ?? false
        stickied =  data.member["stickied "] as? Bool ?? false
        hideScore =  data.member["hideScore "] as? Bool ?? false

        ups =  data.member["ups"] as? Int ?? 0
        score =  data.member["score"] as? Int ?? 0
        downs =  data.member["downs"] as? Int ?? 0
        created =  data.member["created"] as? Int ?? 0
        createdUtc =  data.member["created_utc"] as? Int ?? 0
        numComments =  data.member["numComments"] as? Int ?? 0

        //TODO: Need to implement previews array
        //let previews: [Image] = []

        upvoteRatio  =  data.member["upvoteRatio "] as? Float ?? 0.0

        if let potential =  Sort(rawValue: data.member["sort"] as? String ?? "") {
            sort = potential
        } else {
            sort = Sort.Blank
        }
    }
    
     let id: String
     let url: String
     let name: String
     let likes: String
     let title: String
     let fromId: String
     let domain: String
     let author: String
     let postHint: String
     let selfText: String
     let permalink: String
     let thumbnail: String
     let subreddit: String
     let subredditId: String
     let selfTextHtml: String
     let linkFlairText: String
     let authorFlairText: String
     let linkFlairCssClass: String
     let authorFlairCssClass: String
     
     let nsfw: Bool
     let saved: Bool
     let locked: Bool
     let isSelf: Bool
     let hidden: Bool
     let edited: Bool
     let clicked: Bool
     let visited: Bool
     let archived: Bool
     let stickied: Bool
     let hideScore: Bool
     
     let ups: Int
     let score: Int
     let downs: Int
     let created: Int
     let createdUtc: Int
     let numComments: Int
     
    //let previews: [Image]
     
     let upvoteRatio: Float
    
     let sort: Sort
    
    //MARK: Helper Struct
    struct Image {
        let url: String?
        let height: Int?
        let width: Int?
        var resolution: Int? {
            if (width != nil && height != nil) { return width! * height! }
            else { return nil }
        }
    }
}

