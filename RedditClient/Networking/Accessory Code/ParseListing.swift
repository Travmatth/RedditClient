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
    let comments: CommentTree
    
    //MARK: Class lifecycle
    init?(dataFromNetworking data: NSData) {
        var json: Array<Any>
        var head: [String: AnyObject]
        var tail: [String: Any]
        
        do {
            json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as! Array<AnyObject>
            head = json[0] as? [String: AnyObject] ?? [:]
            tail = json[1] as? [String: AnyObject] ?? [:]
        } catch {
            return nil
        }
        post = PostData(json: head)
        comments = CommentTree(json: tail)
    }
}

class CommentTree {
    init(json: [String: Any]) { }
}

class PostDataFromJson {
    var member: [String: AnyObject]
    
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
}

func == (lhs: PostData, rhs: PostData) -> Bool { return lhs.id == rhs.id }

struct PostData {
    init?(json: [String: AnyObject]) {
        let potentialData = PostDataFromJson(json: json)
        if potentialData == nil { return nil }
        let data = potentialData!

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

        previews =  [Image]

        upvoteRatio  =  data.member["upvoteRatio "] as? Float ?? 0.0

        if let potential =  Sort(rawValue: data.member["sort"] as? String ?? "") {
            sort = potential
        }
    
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
     
     let previews: [Image]
     
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

