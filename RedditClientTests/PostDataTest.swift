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
    var testJson: AnyObject?
    var mut: ParseListing?
    
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        let bundle: NSBundle =  NSBundle(forClass: self.dynamicType)
        let sampleJson: String! = bundle.pathForResource("SampleJsonLinkListing", ofType: nil)
        
        do { testData = try! NSData(contentsOfFile: sampleJson, options: NSDataReadingOptions.DataReadingMappedIfSafe ) }
        //print(String.init(data: testData, encoding: NSUTF8StringEncoding)!)
        //mut = ParseListing(dataFromNetworking: testData!)
    }
    
    func testInit() {
        XCTAssertNotNil(mut, "Class should initalize properly")
    }
    
    /*
    func testPostParse() {
        let domain	=	"cnn.com"
        let subreddit	=	"news"
        let selftext_html	=	nil
        let selftext	=
        let likes	=	nil
        let suggested_sort	=	nil
        let link_flair_text	=	nil
        let id	=	3vfaji
        let from_kind	=	nil
        let archived	=	false
        let clicked	=	false
        let author	=	"aresef"
        let name	=	"t3_3vfaj"i
        let score	=	5467
        let over_18	=	false
        let hidden	=	false
        let thumbnail	=	"http=//b.thumbs.redditmedia.com/BEl8EvVenkUs3jYW1wK6Ok0yTNMlst-jRMbq6C1-FCw.jpg"
        let subreddit_id	=	"t5_2qh3"l
        let edited	=	false
        let link_flair_css_class	=	nil
        let author_flair_css_class	=	nil
        let downs	=	0
        let saved	=	false
        let post_hint	=	"link"
        let stickied	=	false
        let is_self	=	false
        let from_id	=	nil
        let permalink	=	"/r/news/comments/3vfaji/san_bernardino_shooting_attacker_pledged/"
        let locked	=	false
        let hide_score	=	false
        let created	=	1449271555
        let url	=	"http=//www.cnn.com/2015/12/04/us/san-bernardino-shooting/index.html"
        let author_flair_text	=	nil
        let title	=	"San Bernardino shooting: Attacker pledged allegiance to ISIS, officials say"
        let created_utc	=	1449242755
        let ups	=	5467
        let upvote_ratio	=	0.95
        let num_comments	=	6019
        let visited	=	false
    }
    */
}
