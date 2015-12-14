//
//  PostData.swift
//  RedditClient
//
//  Created by Travis Matthews on 12/11/15.
//  Copyright © 2015 Travis Matthews. All rights reserved.
//

import Foundation

func == (lhs: PostData, rhs: PostData) -> Bool { return lhs.id == rhs.id }

struct PostData {
    init?(withJson json: [String: AnyObject]) {
        guard let data = PostDataFromJson(json: json) else {
            return nil
        }

        id =  data.member["id"] as? String ?? ""
        url =  data.member["url"] as? String ?? ""
        name =  data.member["name"] as? String ?? ""
        title =  data.member["title"] as? String ?? ""
        fromId =  data.member["from_id"] as? String ?? ""
        domain =  data.member["domain"] as? String ?? ""
        author =  data.member["author"] as? String ?? ""
        postHint =  data.member["post_hint"] as? String ?? ""
        selfText =  data.member["selftext"] as? String ?? ""
        permalink =  data.member["permalink"] as? String ?? ""
        thumbnail =  data.member["thumbnail"] as? String ?? ""
        subreddit =  data.member["subreddit"] as? String ?? ""
        subredditId =  data.member["subreddit_id"] as? String ?? ""
        selfTextHtml =  data.member["selftext_html"] as? String ?? ""
        linkFlairText =  data.member["link_flair_text"] as? String ?? ""
        authorFlairText =  data.member["author_flair_text"] as? String ?? ""
        linkFlairCssClass =  data.member["link_flair_css_class"] as? String ?? ""
        authorFlairCssClass =  data.member["author_flair_css_class"] as? String ?? ""

        nsfw =  data.member["over_18"] as? Bool ?? false
        saved =  data.member["saved"] as? Bool ?? false
        locked =  data.member["locked"] as? Bool ?? false
        isSelf =  data.member["is_self"] as? Bool ?? false
        hidden =  data.member["hidden"] as? Bool ?? false
        edited =  data.member["edited"] as? Bool ?? false
        clicked =  data.member["clicked"] as? Bool ?? false
        visited =  data.member["visited"] as? Bool ?? false
        archived =  data.member["archived"] as? Bool ?? false
        stickied =  data.member["stickied"] as? Bool ?? false
        hideScore =  data.member["hide_score"] as? Bool ?? false

        ups =  data.member["ups"] as? Int ?? 0
        likes =  data.member["likes"] as? Int ?? 0
        score =  data.member["score"] as? Int ?? 0
        downs =  data.member["downs"] as? Int ?? 0
        created =  data.member["created"] as? Int ?? 0
        createdUtc =  data.member["created_utc"] as? Int ?? 0
        numComments =  data.member["num_comments"] as? Int ?? 0

        //TODO: Need to implement previews array
        var _previews: [Image] = []
        if let preview = data.member["preview"] as? [String: AnyObject] {
            if let image = preview["image"] as? [[String: AnyObject]] {
                if let resolutions = image[1] as? [String: [String: AnyObject]] {
                    for (_, val) in resolutions {
                            _previews.append(Image(withJson: val))
                    }
                }
            }
        }
        previews = _previews
        
        upvoteRatio = NSDecimalNumber(decimal: (data.member["upvote_ratio"] as! NSNumber).decimalValue)
 
        if let potential =  Sort(rawValue: data.member["suggested_sort"] as? String ?? "") {
            sort = potential
        } else {
            sort = Sort.Blank
        }
    }
    
     let id: String
     let url: String
     let name: String
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
     let likes: Int
     let score: Int
     let downs: Int
     let created: Int
     let createdUtc: Int
     let numComments: Int
     
    let previews: [Image]
     
     let upvoteRatio: NSDecimalNumber
    
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
        
        init(withJson json: [String: AnyObject]) {
            self.height = json["height"] as? Int ?? 0
            self.width = json["width"] as? Int ?? 0
            self.url = json["url"] as? String ?? ""
        }
    }
}