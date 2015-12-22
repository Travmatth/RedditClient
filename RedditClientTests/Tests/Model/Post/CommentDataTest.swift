//
//  testCommentData.swift
//  RedditClient
//
//  Created by Travis Matthews on 12/6/15.
//  Copyright © 2015 Travis Matthews. All rights reserved.
//

import XCTest

class testCommentData: XCTestCase {
    var bundle: NSBundle!
    var testData: NSData!
    var testJsonDictionary: [String: AnyObject]!
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
        bundle =  NSBundle(forClass: self.dynamicType)
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testComment() {
        //When
        let sampleJson: String! = bundle.pathForResource("SampleComment", ofType: nil)
        
        do {
            testData = try NSData(contentsOfFile: sampleJson, options: NSDataReadingOptions.DataReadingMappedIfSafe )
            if testData == nil { fatalError("testData null") }
            testJsonDictionary = try NSJSONSerialization.JSONObjectWithData(testData, options: NSJSONReadingOptions.MutableContainers) as! [String: AnyObject]
            if testJsonDictionary == nil { print("testJsonDictionary null") }
            
        }
        catch let error {
            print("\(error)")
        }
        
        //Then
        let mut = CommentData(withJson: testJsonDictionary)
        
        let author = "Asti_"
        let body = "Nice job using python to explain how to solve the types of challenges!"
        let name = "t1_cxw1461"
        let edited = true
        let score = 10
        let ups = 10
        let downs = 10
        let created = 1449913333
        let saved = true
        let subreddit = "ReverseEngineering"
        let subreddit_id = "t5_2qmd0"
        let id = "cxw1461"
        let link_id = "t3_3wg5fx"
        let parent_id = "t3_3wg5fx"
        let score_hidden = true
        let body_html = "&lt;div class=\"md\"&gt;&lt;p&gt;Nice job using python to explain how to solve the types of challenges!&lt;/p&gt;\n&lt;/div&gt;"
        let author_flair_css_class = "test"
        let author_flair_text = "test"
        
        //EXPECT
        XCTAssertEqual(mut.author, author, " should be correct")
        XCTAssertEqual(mut.body, body, " should be correct")
        XCTAssertEqual(mut.name, name, " should be correct")
        XCTAssertEqual(mut.edited, edited, " should be correct")
        XCTAssertEqual(mut.score, score, " should be correct")
        XCTAssertEqual(mut.ups, ups, " should be correct")
        XCTAssertEqual(mut.downs, downs, " should be correct")
        XCTAssertEqual(mut.created, created, " should be correct")
        XCTAssertEqual(mut.saved, saved, " should be correct")
        XCTAssertEqual(mut.subreddit, subreddit, " should be correct")
        XCTAssertEqual(mut.subredditId, subreddit_id, " should be correct")
        XCTAssertEqual(mut.id, id, " should be correct")
        XCTAssertEqual(mut.linkId, link_id, " should be correct")
        XCTAssertEqual(mut.parentId, parent_id, " should be correct")
        XCTAssertEqual(mut.scoreHidden, score_hidden, " should be correct")
        XCTAssertEqual(mut.bodyHtml, body_html, " should be correct")
        XCTAssertEqual(mut.authorFlairCssClass, author_flair_css_class, " should be correct")
        XCTAssertEqual(mut.authorFlairText, author_flair_text, " should be correct")
    }
}