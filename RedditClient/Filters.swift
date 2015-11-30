//
//  Filters.swift
//  RedditClient
//
//  Created by Travis Matthews on 11/20/15.
//  Copyright © 2015 Travis Matthews. All rights reserved.
//

import Foundation


func acceptableStatusCode(response: Response) -> Result<NSData> {
    let successRange = 200..<300
    
    if !successRange.contains(response.statusCode) {
        return .Failure("status code of \(response.statusCode) outside of bounds")
    }
    return .Success(response.data)
}

func fromDataToJSON(data: NSData) -> Result<AnyObject> {
    do {
        let json = try NSJSONSerialization.JSONObjectWithData(data, options: [])
        return Result(value: json)
    } catch {
        return Result(error: "Failure while parsing JSON inside fromDataToJSON")
    }
}

func fromJSONToMulti(json: AnyObject) -> Result<Any> {
    var multiReddits = [Multi]()
    
    if let jsonArray = json as? NSArray {
        for child in jsonArray {
            if let kind = child["kind"] as? String {
                if kind == "LabeledMulti" {
                    if let data = child["data"] as? NSDictionary {
                        var subscriptions = [String]()
                        let name = data["name"] as! String
                        let displayName = data["display_name"] as! String
                        let descriptionHTML = data["description_html"] as! String
                        if let subs = data["subreddits"] as? NSArray {
                            for sub in subs { subscriptions.append(sub["name"] as! String) }
                        multiReddits.append(Multi(subscriptions, descriptionHTML, displayName, name))
                        }
                    }
                }
            }
        }
    }
    return Result(value: multiReddits)
}

func fromJSONToSubreddit(json: AnyObject) -> Result<Any> {
    var posts = [Post]()
    if let response = json as? NSDictionary {
        if let kind = response["kind"] as? String {
            if kind == "Listing" {
                if let listing = response["data"] as? NSDictionary {
                    let before = listing["before"] as? String ?? nil
                    let after = listing["after"] as? String ?? nil
                    if let children = listing["children"] as? NSArray {
                        for child in children {
                            if let subredditPost = child["data"] as? NSDictionary {
                                let kind = subredditPost["kind"] as? String ?? ""
                                let id = subredditPost["id"] as? String ?? ""
                                let selfText = subredditPost["selfText"] as? String ?? ""
                                let ups = subredditPost["ups"] as? Int ?? 0
                                let linkFlairText = subredditPost["linkFlairText"] as? String ?? ""
                                let archived = subredditPost["archived"] as? Bool ?? false
                                let clicked = subredditPost["clicked"] as? Bool ?? false
                                let author = subredditPost["author"] as? String ?? ""
                                let media = subredditPost["media"]
                                let nsfw = subredditPost["nsfw"] as? Bool ?? false
                                let hidden = subredditPost["hidden"] as? Bool ?? false
                                let numComments = subredditPost["numComments"] as? Int ?? 0
                                let thumbnail = subredditPost["thumbnail"]
                                let saved = subredditPost["saved"] as? Bool ?? false
                                let permalink = subredditPost["permalink"] as? String ?? ""
                                let locked = subredditPost["locked"] as? Bool ?? false
                                let name = subredditPost["name"] as? String ?? ""
                                let created = subredditPost["created"] as? Int ?? 0
                                let authorFlairText = subredditPost["authorFlairText"]
                                let title = subredditPost["title"] as? String ?? ""
                                let createdUTC = subredditPost["createdUTC"] as? Int ?? 0
                                let distinguished = subredditPost["distinguished"]
                                let visited = subredditPost["visited"] as? Bool ?? false
                                let sub = subredditPost["subreddit"] as? String ?? ""
                                let subredditId = subredditPost["subreddit_id"] as? String ?? ""
                                
                                let post = Post(before, after, kind, id, selfText, ups, linkFlairText, archived, clicked, author, media, nsfw, hidden, numComments, thumbnail, saved, permalink, locked, name, created, authorFlairText, title, createdUTC, distinguished, visited, sub, subredditId)
                                
                                posts.append(post)
                            }
                        }
                    }
                }
            }
        }
    }
    return Result(value: posts)
}

func fromDataToJSONArray(data: NSData) -> Result<AnyObject> {
    do {
        let json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers)
        return Result(value: json)
    } catch {
        return Result(error:"Failed to convert JSON to NSArray")
    }
}

func fromJSONToUser(json: AnyObject) -> Result<AnyObject> {
    var user: String = ""
    
    if let dict = json as? NSDictionary {
        user = dict["name"] as! String
    }
    return Result(value: user)
}

typealias Karma = (subreddit: String, karma: Int)

func fromJSONToKarmaBreakdown(json: AnyObject) -> Result<Any> {
    var subredditKarmaBreakdown: [Karma] = []
    if let kind = json["kind"] as? String {
        if kind == "KarmaList" {
            if let nodes = json["data"] as? NSArray {
                for node in nodes {
                    let subreddit = node["sr"] as! String
                    let commentKarma = node["comment_karma"] as! Int
                    let linkKarma = node["link_karma"] as! Int
                    let subKarma = Karma(subreddit, commentKarma + linkKarma)
                    subredditKarmaBreakdown.append(subKarma)
                }
            }
        }
    }
    subredditKarmaBreakdown.sortInPlace({$0.karma > $1.karma})
    return Result(value: subredditKarmaBreakdown)
}

func fromJSONToSubredditRecommendations(json: AnyObject) -> Result<Any> {
    var subRecommends: [String] = []
    
    if let json = json as? NSArray {
        for node in json {
            let sub = node["sr_name"] as! String
            subRecommends.append(sub)
        }
    }
    return Result(value: subRecommends)
}
