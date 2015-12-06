//
//  TreeNodeTests.swift
//  RedditClient
//
//  Created by Travis Matthews on 12/3/15.
//  Copyright © 2015 Travis Matthews. All rights reserved.
//

import XCTest

class TreeNodeTests: XCTestCase {
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }
    
    func testNullInitializer() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        //let modelUnderTest: CommentNode = CommentNode(json: "Nonsense")
        
        /*
        XCTAssertEqual(modelUnderTest.replies.count, 0, "w/ null initialization, body should be blank")
        XCTAssertEqual(modelUnderTest.details["body"], "", "w/ null initialization, body should be blank")
        XCTAssertEqual(modelUnderTest.details["name"], "", "w/ null initialization, name should be blank")
        XCTAssertEqual(modelUnderTest.details["author"], "", "w/ null initialization, author should be blank")
        XCTAssertEqual(modelUnderTest.details["bodyHtml"], "", "w/ null initialization, author should be blank")
        
        XCTAssertEqual(modelUnderTest.details["authorFlairCssClass"], "", "w/ null initialization, author_flair_css_class should be blank")
        XCTAssertEqual(modelUnderTest.details["authorFlairText"], "", "w/ null initialization, author_flair_css_text should be blank")
        
        
        XCTAssertEqual(modelUnderTest.details["ups"], 0,  "w/ null initialization, ups should be 0")
        XCTAssertEqual(modelUnderTest.details["downs"], 0,  "w/ null initialization, downs should be 0")
        XCTAssertEqual(modelUnderTest.details["score"], 0,  "w/ null initialization, score should be 0")
        XCTAssertFalse(modelUnderTest.details["saved"],  "w/ null initialization, saved should be false")
        XCTAssertFalse(modelUnderTest.details["edited"], "w/ null initialization, edited should be false")
        XCTAssertEqual(modelUnderTest.details["created"], 0,  "w/ null initialization, created should be 0")
        
        XCTAssertEqual(modelUnderTest.details["id"], "", "w/ null initialization, id should be blank")
        XCTAssertEqual(modelUnderTest.details["linkId"], "", "w/ null initialization, linkId should be blank")
        XCTAssertEqual(modelUnderTest.details["parentId"], "", "w/ null initialization, parentId should be blank")
        XCTAssertEqual(modelUnderTest.details["subreddit"], "", "w/ null initialization, subreddit should be blank")
        XCTAssertEqual(modelUnderTest.details["subredditId"], "", "w/ null initialization, subredditId should be blank")
        XCTAssertEqual(modelUnderTest.kind, TypePrefix.Null, "w/ null initialization, kind should be null")
        
        XCTAssertFalse(modelUnderTest.scoreHidden, "w/ null initialization, scoreHidden should be false")
        */
    }
 
    func testJsonInitializerFor() {
        /*
        let bundle: NSBundle =  NSBundle(forClass: self.dynamicType)
        let sampleJson: String! = bundle.pathForResource("SampleJsonLinkListing", ofType: nil)
        var testData: NSData
        
        NSLog("sample: \(sampleJson)")
        
        do { testData = try! NSData(contentsOfFile: sampleJson, options:[] ) }
        
        var testJson: AnyObject?
        do { testJson = try! NSJSONSerialization.JSONObjectWithData(testData, options: NSJSONReadingOptions.MutableContainers) as! NSArray }
        
        //print("test: \(testJson![1]))")
        let modelUnderTest: CommentTree = CommentTree(json: testJson![1])!
        NSLog("count: \(modelUnderTest.count)")
        // nut = node under test
        let flat: [CommentNode] = modelUnderTest.flattened
        let nut = flat[0]
        
        let body = "Used their phones to talk, used Facebook to pledge fealty.\n\nGood work, NSA. Keep up the good work. Let me know if we can pass any new laws for you. Hope one day you can crack this complex code they were using.\n\n**Revised Edit**: my post was based on an MSNBC story which didn't report that the Facebook posts were (according to intelligence agencies) made during the attack, but regardless, the phone calls were made earlier.\n\n**Another Edit** is easier than responding to everyone: I have just two points to make...\n\n- Farook called overseas contacts (therefore, NSA jurisdiction) who were under investigation for terrorism\n- Farook and/or his wife purchased guns\n\nIf neither the NSA nor the FBI can connect these 2 data points and act on them, we should all be very angry about that.\n\n[I would like everyone to read therealhuthaifa's post](https://www.reddit.com/r/news/comments/3vfaji/san_bernardino_shooting_attacker_pledged/cxn0l5l)"
        
        let body_html: String = "<div class=\"md\"><p>Used their phones to talk, used Facebook to pledge fealty.</p>\n\n<p>Good work, NSA. Keep up the good work. Let me know if we can pass any new laws for you. Hope one day you can crack this complex code they were using.</p>\n\n<p><strong>Revised Edit</strong>: my post was based on an MSNBC story which didn&#39;t report that the Facebook posts were (according to intelligence agencies) made during the attack, but regardless, the phone calls were made earlier.</p>\n\n<p><strong>Another Edit</strong> is easier than responding to everyone: I have just two points to make...</p>\n\n<ul>\n<li>Farook called overseas contacts (therefore, NSA jurisdiction) who were under investigation for terrorism</li>\n<li>Farook and/or his wife purchased guns</li>\n</ul>\n\n<p>If neither the NSA nor the FBI can connect these 2 data points and act on them, we should all be very angry about that.</p>\n\n<p><a href=\"https://www.reddit.com/r/news/comments/3vfaji/san_bernardino_shooting_attacker_pledged/cxn0l5l\">I would like everyone to read therealhuthaifa&#39;s post</a></p>\n</div>"
        
        XCTAssertEqual(nut.details!.ups, 4464,  "w/ json initialization, ups should be 2")
        XCTAssertEqual(nut.details!.downs, 0,  "w/ null initialization, downs should be 0")
        XCTAssertEqual(nut.details!.score, 4464,  "w/ null initialization, score should be 0")
        XCTAssertEqual(nut.details!.replies!.count, 2, "w/ json initialization, replies should be 2")
        XCTAssertEqual(nut.details!.body, body, "w/ null initialization, body should be blank")
        XCTAssertEqual(nut.details!.id, "cxn09qo", "w/ null initialization, id should be blank")
        XCTAssertEqual(nut.details!.created, 1449244457, "w/ null initialization, created should be 0")
        XCTAssertEqual(nut.details!.bodyHtml, body_html, "w/ null initialization, author should be blank")
        XCTAssertEqual(nut.details!.linkId, "t3_3vfaji", "w/ null initialization, linkId should be blank")
        XCTAssertEqual(nut.details!.subreddit, "news", "w/ null initialization, subreddit should be blank")
        XCTAssertEqual(nut.details!.kind, TypePrefix.Comment, "w/ null initialization, kind should be null")
        XCTAssertEqual(nut.details!.name, "t1_cxn09qo", "w/ json initialization, name should be t1_cxn09qo")
        XCTAssertEqual(nut.details!.parentId, "t3_3vfaji", "w/ null initialization, parentId should be blank")
        XCTAssertEqual(nut.details!.author, "RazzleFrazzapan", "w/ null initialization, author should be blank")
        XCTAssertEqual(nut.details!.subredditId, "t5_2qh3l", "w/ null initialization, subredditId should be blank")
        
        //TODO: Find test sample for .authorFlairCssClass
        XCTAssertEqual(nut.details!.authorFlairCssClass, "", "w/ null initialization, author_flair_css_class should be blank")
        //TODO: Find test sample for .authorFlairText
        XCTAssertEqual(nut.details!.authorFlairText, "", "w/ this initialization, author_flair_css_text should be blank")
        
        
        XCTAssertFalse(nut.details!.saved,  "w/ null initialization, saved should be false")
        XCTAssertFalse(nut.details!.edited, "w/ null initialization, edited should be false")
        XCTAssertFalse(nut.details!.scoreHidden, "w/ SampleJsonLinkListing initialization, scoreHidden should be false")
        */
    }

    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
    
}

        