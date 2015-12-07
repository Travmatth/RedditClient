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
    init?(json: JsonDict) {
        let root = json["data"]!
        if let prefix = root["children"][0]["kind"].string {
            let kind = TypePrefix(rawValue: prefix)
            
            if kind != nil {
                print("enum")
                switch kind! {
                case .Link:
                    
                    print("link")
                    fatalError("base is nil?")
                    let base = root["children"][0].dictionary
                    
                    archived = base!["archived"]?.boolValue ?? false
                    author = base?["author"]?.stringValue ?? ""
                    authorFlairCssClass = base?["author_flair_css_class"]?.stringValue ?? ""
                    authorFlairText = base?["author_flair_text"]?.stringValue ?? ""
                    clicked = base?["clicked"]?.boolValue ?? false
                    created = base?["created"]?.intValue ?? 0
                    createdUtc = base?["created_utc"]?.intValue ?? 0
                    domain = base?["domain"]?.stringValue ?? ""
                    downs = base?["downs"]?.intValue ?? 0
                    edited = base?["edited"]?.boolValue ?? false
                    fromId = base?["from_id"]?.stringValue ?? ""
                    hidden = base?["hidden"]?.boolValue ?? false
                    hideScore = base?["hide_score"]?.boolValue ?? false
                    id = base?["id"]?.stringValue ?? ""
                    isSelf = base?["is_self"]?.boolValue ?? false
                    likes = base?["likes"]?.stringValue ?? ""
                    linkFlairText = base?["link_flair_text"]?.stringValue ?? ""
                    linkFlairCssClass = base?["link_flair_css_class"]?.stringValue ?? ""
                    locked = base?["locked"]?.boolValue ?? false
                    name = base?["]name"]?.stringValue ?? ""
                    numComments = base?["num_comments"]?.intValue ?? 0
                    nsfw = base?["over_18"]?.boolValue ?? false
                    permalink = base?["permalink"]?.stringValue ?? ""
                    postHint = base?["post_hint"]?.stringValue ?? ""
                    saved = base?["saved"]?.boolValue ?? false
                    selfText = base?["selftext"]?.stringValue ?? ""
                    selfTextHtml = base?["selftext_html"]?.stringValue ?? ""
                    score = base?["score"]?.intValue ?? 0
                    stickied = base?["stickied"]?.boolValue ?? false
                    subreddit = base?["subreddit"]?.stringValue ?? ""
                    subredditId = base?["subreddit_id"]?.stringValue ?? ""
                    title = base?["title"]?.stringValue ?? ""
                    thumbnail = base?["]thumbnail"]?.stringValue ?? ""
                    url = base?["url"]?.stringValue ?? ""
                    ups = base?["ups"]?.intValue ?? 0
                    upvoteRatio = base?["upvote_ratio"]?.floatValue ?? 0.0
                    visited = base?["visited"]?.boolValue ?? false
                    
                    if let _sort = base?["suggested_sort"]?.stringValue {
                        self.sort = Sort(rawValue: _sort)!
                    } else { self.sort = .Top }
                    
                    /* Parse the preview */
                    if let resolutions = base?["preview"]?["images"][0]["resolutions"].array {
                        var _temp: [Image] = []
                        for pic in resolutions {
                            let img = Image(url: pic["url"].stringValue, height: pic["height"].intValue, width: pic["width"].intValue)
                            _temp.append(img)
                        }
                        self.previews = _temp
                        
                    } else { self.previews = [] }
                    return
                    
                default:
                    print("return nil from default")
                    return nil
                }
            }
        }
        print("return nil from init")
        return nil
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