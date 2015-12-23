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
        let data = String(data: response.data, encoding: NSUTF8StringEncoding)
        return .Failure(RedditClientError.NetworkError.StatusCodeOutOfRange(code: data))
    }
    return .Success(response.data)
}

func fromDataToJSON(data: NSData) -> Result<AnyObject> {
    do {
        let json = try NSJSONSerialization.JSONObjectWithData(data, options: [])
        return Result(value: json)
    } catch {
        return .Failure(RedditClientError.ParsingError.FailedJsonConversion)
    }
}

func fromJSONToMulti(json: AnyObject) -> Result<Any> {
    var multiReddits = [Multi]()
    
    if let jsonArray = json as? [AnyObject] {
        for child in jsonArray {
            if let kind = child["kind"] as? String {
                if kind == "LabeledMulti" {
                    if let data = child["data"] as? [String: AnyObject] {
                        var subscriptions = [String]()
                        let name = data["name"] as? String ?? ""
                        let displayName = data["display_name"] as? String ?? ""
                        let descriptionHTML = data["description_html"] as? String ?? ""
                        if let subs = data["subreddits"] as? [AnyObject] {
                            for sub in subs { subscriptions.append(sub["name"] as? String ?? "") }
                        multiReddits.append(Multi(subscriptions, descriptionHTML, displayName, name))
                        }
                    }
                }
            }
        }
    }
    return Result(value: multiReddits)
}

func fromDataToJSONArray(data: NSData) -> Result<AnyObject> {
    do {
        let json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers)
        return Result(value: json)
    } catch {
        return .Failure(RedditClientError.ParsingError.FailedJsonConversion)
    }
}

func fromJSONToUser(json: AnyObject) -> Result<AnyObject> {
    var user: String = ""
    
    if let dict = json as? [String: AnyObject] {
        user = dict["name"] as! String
    }
    return Result(value: user)
}

typealias Karma = (subreddit: String, commentKarma: Int, linkKarma: Int)

func fromJSONToKarmaBreakdown(json: AnyObject) -> Result<Any> {
    var subredditKarmaBreakdown: [Karma] = []
    if let kind = json["kind"] as? String {
        if kind == "KarmaList" {
            if let nodes = json["data"] as? [AnyObject] {
                for node in nodes {
                    let subreddit = node["sr"] as? String ?? ""
                    let commentKarma = node["comment_karma"] as? Int ?? 0
                    let linkKarma = node["link_karma"] as? Int ?? 0
                    let subKarma = Karma(subreddit, commentKarma, linkKarma)
                    subredditKarmaBreakdown.append(subKarma)
                }
            }
        }
    }
    subredditKarmaBreakdown.sortInPlace({$0.commentKarma > $1.commentKarma})
    return Result(value: subredditKarmaBreakdown)
}

func fromJSONToSubredditRecommendations(json: AnyObject) -> Result<Any> {
    var subRecommends: [String] = []
    
    if let json = json as? [AnyObject] {
        for node in json {
            let sub = node["sr_name"] as? String ?? "No Reddits Found"
            //subRecommends.append(node["sr_name"] as? String ?? "No Reddits Found")
            subRecommends.append(sub)
        }
    }
    return Result(value: subRecommends)
}
