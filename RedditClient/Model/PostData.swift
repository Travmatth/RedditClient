//
//  PostData.swift
//  RedditClient
//
//  Created by Travis Matthews on 12/6/15.
//  Copyright © 2015 Travis Matthews. All rights reserved.
//

import Foundation

func == (lhs: PostData, rhs: PostData) -> Bool { return lhs.id == rhs.id }

struct PostData {
    init?(json: JSON) {
        //let t = json["data"]["children"][0]["kind"][0].string()
        //print(t)
        if let prefix = json["data"]["children"][0]["kind"].string {
            let kind = TypePrefix(rawValue: prefix)
            
            if kind != nil {
                switch kind! {
                case .Link:
                    let base = json["data"]["children"]["data"].dictionary
                    
                    archived = base?["archived"]?.bool
                    author = base?["]author"]?.string
                    authorFlairCssClass = base?["author_flair_css_class"]?.string
                    authorFlairText = base?["author_flair_text"]?.string
                    clicked = base?["clicked"]?.bool
                    created = base?["created"]?.int
                    createdUtc = base?["created_utc"]?.int
                    domain = base?["domain"]?.string
                    downs = base?["downs"]?.int
                    edited = base?["edited"]?.bool
                    fromId = base?["from_id"]?.string
                    hidden = base?["hidden"]?.bool
                    hideScore = base?["hide_score"]?.bool
                    id = base?["id"]?.string
                    isSelf = base?["is_self"]?.bool
                    likes = base?["likes"]?.string
                    linkFlairText = base?["link_flair_text"]?.string
                    linkFlairCssClass = base?["link_flair_css_class"]?.string
                    locked = base?["locked"]?.bool
                    name = base?["]name"]?.string
                    numComments = base?["num_comments"]?.int
                    nsfw = base?["over_18"]?.bool
                    permalink = base?["permalink"]?.string
                    postHint = base?["post_hint"]?.string
                    saved = base?["saved"]?.bool
                    selfText = base?["selftext"]?.string
                    selfTextHtml = base?["selftext_html"]?.string
                    score = base?["score"]?.int
                    stickied = base?["stickied"]?.bool
                    subreddit = base?["subreddit"]?.string
                    subredditId = base?["subreddit_id"]?.string
                    title = base?["title"]?.string
                    thumbnail = base?["]thumbnail"]?.string
                    url = base?["url"]?.string
                    ups = base?["ups"]?.int
                    upvoteRatio = base?["upvote_ratio"]?.float
                    visited = base?["visited"]?.bool
                    
                    if let _sort = base?["suggested_sort"]?.string {
                        self.sort = Sort(rawValue: _sort)!
                    }
                    
                    /* Parse the preview */
                    if let resolutions = base?["preview"]?["images"][0]["resolutions"].array {
                        var _temp: [Image] = []
                        for pic in resolutions {
                            let img = Image(url: pic["url"].string, height: pic["height"].int, width: pic["width"].int)
                            _temp.append(img)
                        }
                        self.previews = _temp
                        
                    }
                    
                default:
                    print("return nil from default")
                    return nil
                }
            }
        } else { print("\(json["data"]["children"][0]["kind"].error)") }
        print("return nil from init")
        return nil
    }

    
    let id: String?
    let url: String?
    let name: String?
    let likes: String?
    let title: String?
    let fromId: String?
    let domain: String?
    let author: String?
    let postHint: String?
    let selfText: String?
    let permalink: String?
    let thumbnail: String?
    let subreddit: String?
    let subredditId: String?
    let selfTextHtml: String?
    let linkFlairText: String?
    let authorFlairText: String?
    let linkFlairCssClass: String?
    let authorFlairCssClass: String?
    
    let nsfw: Bool?
    let saved: Bool?
    let locked: Bool?
    let isSelf: Bool?
    let hidden: Bool?
    let edited: Bool?
    let clicked: Bool?
    let visited: Bool?
    let archived: Bool?
    let stickied: Bool?
    let hideScore: Bool?
    
    let ups: Int?
    let score: Int?
    let downs: Int?
    let created: Int?
    let createdUtc: Int?
    let numComments: Int?
    
    let previews: [Image]?
    
    let upvoteRatio: Float?
    
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