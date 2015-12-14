//
//  PostDataTest.swift
//  RedditClient
//
//  Created by Travis Matthews on 12/6/15.
//  Copyright © 2015 Travis Matthews. All rights reserved.
//

import XCTest

class PostDataTest: XCTestCase {
    
    var testData: NSData!
    var testJson: [AnyObject]!
    
    let domain = "codesigning.guide"
    let subreddit = "iOSProgramming"
    let selftext_html = "test"
    let selftext = "test"
    let likes = 10
    let suggested_sort = "top"
    let link_flair_text = "Website"
    let id = "3w9e9a"
    let from_kind = "test"
    let archived = true
    let clicked = true
    let author = "felixkk"
    //let media = "test"
    let post_name = "t3_3w9e9a"
    let score = 18
    let over_18 = true
    let hidden = true
    let thumbnail = "default"
    let subreddit_id = "t5_2s61a"
    let edited = true
    let link_flair_css_class = "tutorial"
    let author_flair_css_class = "test"
    let downs = 10
    let saved = true
    let stickied = true
    //let from = "test"
    let is_self = true
    let from_id = "test"
    let permalink = "/r/iOSProgramming/comments/3w9e9a/a_new_approach_to_ios_code_signing_easily_sync/"
    //let locked = true
    let hide_score = true
    let created = 1449802653
    let url = "https://codesigning.guide/"
    let author_flair_text = "test"
    let title = "A new approach to iOS code signing: Easily sync your certificates and profiles across your team using git"
    let created_utc = 1449773853
    let ups = 18
    let upvote_ratio: NSDecimalNumber = 0.78
    let num_comments = 8
    let visited = true
    
    var sampleJson: [String: AnyObject]!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let bundle: NSBundle =  NSBundle(forClass: self.dynamicType)
        let jsonFile: String! = bundle.pathForResource("SampleLinkPost", ofType: nil)
        
        do {
            testData = try NSData(contentsOfFile: jsonFile, options: NSDataReadingOptions.DataReadingMappedIfSafe )
            if testData == nil { print("here") }
            testJson = try NSJSONSerialization.JSONObjectWithData(testData, options: NSJSONReadingOptions.MutableContainers) as! [AnyObject]
        }
        catch let error {
            print(error)
        }
        
        var json = testJson[0] as! [String: AnyObject]
        json = json["data"] as! [String: AnyObject]
        var js = json["children"] as! [AnyObject]
        sampleJson = js[0] as! [String: AnyObject]
        XCTAssertNotNil(testJson)
    }
    
    
    
    func testPostData() {
        
        var mut = PostData(withJson: sampleJson)!
        
        XCTAssertEqual(mut.domain, domain, "Domain should be correct")
        XCTAssertEqual(mut.subreddit, subreddit, "Subreddit should be correct")
        XCTAssertEqual(mut.selfTextHtml, selftext_html, "selftext_html should be correct")
        XCTAssertEqual(mut.selfText, selftext, "selftext should be correct")
        XCTAssertEqual(mut.likes, likes, "likes should be correct")
        XCTAssertEqual(mut.sort.rawValue, suggested_sort, "suggested_sort should be correct")
        XCTAssertEqual(mut.linkFlairText, link_flair_text, "link_flair_text should be correct")
        XCTAssertEqual(mut.id, id, "ID should be correct")
        XCTAssertEqual(mut.fromId, from_id, "from_kind should be correct")
        XCTAssertEqual(mut.archived, archived, "archived should be correct")
        XCTAssertEqual(mut.clicked, clicked, "clicked should be correct")
        XCTAssertEqual(mut.author, author, "author should be correct")
        XCTAssertEqual(mut.author, author, "author should be correct")
        XCTAssertEqual(mut.name, post_name, "name should be correct")
        XCTAssertEqual(mut.score, score, "score should be correct")
        XCTAssertEqual(mut.nsfw, over_18, "nsfw should be correct")
        XCTAssertEqual(mut.hidden, hidden, "hidden should be correct")
        XCTAssertEqual(mut.thumbnail, thumbnail, "thumbnail should be correct")
        XCTAssertEqual(mut.thumbnail, thumbnail, "thumbnail should be correct")
        XCTAssertEqual(mut.subredditId, subreddit_id, "subreddit_id should be correct")
        XCTAssertEqual(mut.edited, edited, "edited should be correct")
        XCTAssertEqual(mut.linkFlairCssClass, link_flair_css_class, "link_flair_css_class should be correct")
        XCTAssertEqual(mut.authorFlairCssClass, author_flair_css_class, "author_flair_css_class should be correct")
        XCTAssertEqual(mut.downs, downs, "downs should be correct")
        XCTAssertEqual(mut.saved, saved, "saved should be correct")
        XCTAssertEqual(mut.stickied, stickied, "stickied should be correct")
        XCTAssertEqual(mut.isSelf, is_self, "is_self should be correct")
        XCTAssertEqual(mut.isSelf, is_self, "is_self should be correct")
        XCTAssertEqual(mut.permalink, permalink, "permalink should be correct")
        XCTAssertEqual(mut.hideScore, hide_score, "hideScore should be correct")
        XCTAssertEqual(mut.created, created, "created should be correct")
        XCTAssertEqual(mut.url, url, "url should be correct")
        XCTAssertEqual(mut.authorFlairText, author_flair_text, "author_flair_text should be correct")
        XCTAssertEqual(mut.title, title, "title should be correct")
        XCTAssertEqual(mut.createdUtc, created_utc, "created_utc should be correct")
        XCTAssertEqual(mut.ups, ups, "ups should be correct")
        XCTAssertEqual(mut.upvoteRatio, upvote_ratio, "upvote_ratio should be correct")
        XCTAssertEqual(mut.numComments, num_comments, "num_comments should be correct")
        XCTAssertEqual(mut.visited, visited, "visited should be correct")
    }
    
}

