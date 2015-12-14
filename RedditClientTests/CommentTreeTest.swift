//
//  CommentTreeTest.swift
//  RedditClient
//
//  Created by Travis Matthews on 12/13/15.
//  Copyright © 2015 Travis Matthews. All rights reserved.
//

import XCTest

class CommentTreeTest: XCTestCase {
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
    
    func testCommentTreeInit() {
        //WHEN
        let sampleJson: String! = bundle.pathForResource("CommentTreeTestSample", ofType: nil)
        
        do {
            testData = try NSData(contentsOfFile: sampleJson, options: NSDataReadingOptions.DataReadingMappedIfSafe )
            if testData == nil { print("nil here too") }
            testJsonDictionary = try NSJSONSerialization.JSONObjectWithData(testData, options: NSJSONReadingOptions.MutableContainers) as! [String: AnyObject]
            if testData == nil { print("nil here too") }
        }
        catch let error {
            print("\(error)")
        }
        
        //THEN
        let mut = CommentTree(json: testJsonDictionary)
        
        XCTAssertEqual(mut?.tree?.descendantCount, 6, "Tree should have correct number of parent comments")
        
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }
}
