//
//  TreeTest.swift
//  RedditClient
//
//  Created by Travis Matthews on 12/5/15.
//  Copyright © 2015 Travis Matthews. All rights reserved.
//

import XCTest

class TreeTest: XCTestCase {
    // Why isn't this working?
    let mut = Tree<String>(withValue: "Root")
    
    let nut0 = Tree<String>(withValue: "A")
    let nut1 = Tree<String>(withValue: "B")
    let nut2 = Tree<String>(withValue: "C")
    let nut3 = Tree<String>(withValue: "D")
    let nut4 = Tree<String>(withValue: "E")
    let nut5 = Tree<String>(withValue: "F")
    let nut6 = Tree<String>(withValue: "G")
    
    
    override func setUp() {
        super.setUp()
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        super.tearDown()
    }

    func testTreeInit() {
        XCTAssertNotNil(mut)
    }
    
    func testNodeInit() {
        XCTAssertNotNil(nut0)
        
    }
    
    func testAddingNodeToTree() {
        mut.addChild(nut0)
        mut.addChild(nut1)
        
        XCTAssertEqual(mut.children.count, 2, "Should correctly add child to children")
        XCTAssert(nut0.parent === mut, "Child should correctly reference parent") // === compare references
        XCTAssertEqual(mut.children[0].depth, 1, "Child should have the correct depth")
    }
    
    func testIsEqual() {
        
        nut0.addChild(nut1)
        mut.addChild(nut0)
        
        NSLog("\(mut.children[0].children[0].value), \(nut1.value)")
        XCTAssertTrue(mut.children[0].children[0].isEquatable(to: nut1.value!))
    }
    
    func testFlattened() {
        nut1.addChild(nut0) // [B, [A]]
        nut2.addChild(nut1) // [C, [B, [A]]]
        
        nut3.addChild(nut4) // [D, [E]]
        nut6.addChild(nut5) // [G, [F]]
        
        
        mut.addChild(nut2) // [C, [B, [A]]]
        mut.addChild(nut3) // [C, [B, [A]]], [D, [E]]
        mut.addChild(nut6) // [C, [B, [A]]], [D, [E]], [G, [F]]
        
        let expected: Array<String> = ["C", "B", "A", "D", "E", "G", "F"]
        XCTAssertEqual(mut.flatten, expected, "Tree should flatten correctly")
    }
    
    func testInsertAfterNodeWithIdentifier() {
        nut1.addChild(nut0) // [B, [A]]
        nut2.addChild(nut1) // [C, [B, [A]]]
        
        nut3.addChild(nut4) // [D, [E]]
        nut6.addChild(nut5) // [G, [F]]
        
        
        mut.addChild(nut2) // [C, [B, [A]]]
        mut.addChild(nut3) // [C, [B, [A]]], [D, [E]]
        mut.addChild(nut6) // [C, [B, [A]]], [D, [E]], [G, [F]]
        
        let expected: Array<String> = ["C", "B", "A", "D", "Fuck Yea", "E", "G", "F"]
        
        let success = Tree<String>(withValue: "Fuck Yea")
        mut.insertAfterNodeWithIdentifier("D", withTree: success, atIndex: 0)
        XCTAssertEqual(mut.flatten, expected, "Tree should add nodes correctly")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }

}
