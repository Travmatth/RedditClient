//
//  LinkListing.swift
//  RedditClient
//
//  Created by Travis Matthews on 12/23/15.
//  Copyright © 2015 Travis Matthews. All rights reserved.
//

import Foundation

struct LinkListing {
    let listing: [PostData]
    let before: String?
    let after: String?
    
    init?(fromData data: NSData) {
        var json: [String: AnyObject]
        
        do {
            json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers) as! [String: AnyObject]
        }
        catch let error {
            NSLog("\(error)")
            listing = []
            before = nil
            after = nil
            return
        }
        
        let linkListing = LinkListingFromJson(withJson: json)
        listing = linkListing.posts
        before = linkListing.before
        after = linkListing.after
    }
}

class LinkListingFromJson {
    var json: [String: AnyObject]?
    
    var before: String? {
        guard json != nil else { return nil }
        return json!["before"] as? String ?? nil
    }
    
    var after: String? {
        guard json != nil else { return nil }
        return json!["after"] as? String ?? nil
        
    }
    
    /* It seems like post is an array?
    ["data": {
    "approved_by" = "<null>";
    archived = 0;
    author = Letly;
    "author_flair_css_class" = "<null>";
    "author_flair_text" = "<null>";
    "banned_by" = "<null>";
    clicked = 0;
    created = 1450898327;
    "created_utc" = 1450869527;
    distinguished = "<null>";
    domain = "self.AskReddit";
    downs = 0;
    edited = 0;
    from = "<null>";
    "from_id" = "<null>";
    "from_kind" = "<null>";
    gilded = 0;
    hidden = 0;
    "hide_score" = 0;
    id = 3xyagj;
    "is_self" = 1;
    likes = "<null>";
    "link_flair_css_class" = "<null>";
    "link_flair_text" = "<null>";
    locked = 0;
    media = "<null>";
    "media_embed" =     {
    };
    "mod_reports" =     (
    );
    name = "t3_3xyagj";
    "num_comments" = 9296;
    "num_reports" = "<null>";
    "over_18" = 0;
    permalink = "/r/AskReddit/comments/3xyagj/whats_the_most_ridiculous_thing_youve_bullshitted/";
    quarantine = 0;
    "removal_reason" = "<null>";
    "report_reasons" = "<null>";
    saved = 0;
    score = 4158;
    "secure_media" = "<null>";
    "secure_media_embed" =     {
    };
    selftext = "";
    "selftext_html" = "<null>";
    stickied = 0;
    subreddit = AskReddit;
    "subreddit_id" = "t5_2qh1i";
    "suggested_sort" = "<null>";
    thumbnail = self;
    title = "What's the most ridiculous thing you've bullshitted someone into believing?";
    ups = 4158;
    url = "https://www.reddit.com/r/AskReddit/comments/3xyagj/whats_the_most_ridiculous_thing_youve_bullshitted/";
    "user_reports" =     (
    );
    visited = 0;
    }, "kind": t3]
 
    */
    var posts: [PostData] {
        guard json != nil else { return [] }
        var _posts: [PostData] = []
        if let data = json!["children"] as? [AnyObject] {
            for post in data {
                print("\(post)")
                let postData = post[0] as? [String: AnyObject]
                _posts.append(PostData(withJson: postData))
            }
        }
        return _posts
        
    }
    
    init(var withJson rawJson: [String: AnyObject]) {
        if let
            kind = rawJson["kind"] as? String,
            data = rawJson["data"] as? [String: AnyObject] {
                guard kind == "Listing" else { return }
                json = data
        }
    }
}