//
//  TreeTest.swift
//  RedditClient
//
//  Created by Travis Matthews on 12/5/15.
//  Copyright © 2015 Travis Matthews. All rights reserved.
//

import XCTest

class TreeTest: XCTestCase {
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
        let blankMut = Tree<String>()
        XCTAssertNil(blankMut.value, "Blank init should have nil value")
        XCTAssertEqual(blankMut.depth, 0, "Root should have depth of 0")
        XCTAssertNil(blankMut.parent, "root shouldn't have parent")
        XCTAssertTrue(mut.visible, "mut should be visible")
        XCTAssertEqual(blankMut.children.count, 0, "Children should be empty")
        XCTAssertTrue(blankMut.isRoot, "mut should be root")
        XCTAssertNil(blankMut.flattenedTreeCache, "cache should be nil")
    }

    func testTreeInitWithValue() {
        XCTAssertNotNil(mut)
        XCTAssertEqual(mut.value!, "Root")
        XCTAssertEqual(mut.depth, 0, "Root should have depth of 0")
        XCTAssertNil(mut.parent, "root shouldn't have parent")
        XCTAssertTrue(mut.visible, "mut should be visible")
        XCTAssertEqual(mut.children.count, 0, "Children should be empty")
        XCTAssertTrue(mut.isRoot, "mut should be root")
        XCTAssertNil(mut.flattenedTreeCache, "cache should be nil")
        
    }
    
    func treeWithNodesPreInserted() -> Tree<String> {
        nut1.addChild(nut0) // [B, [A]]
        nut2.addChild(nut1) // [C, [B, [A]]]
        
        nut3.addChild(nut4) // [D, [E]]
        nut6.addChild(nut5) // [G, [F]]
        
        
        mut.addChild(nut2) // [C, [B, [A]]]
        mut.addChild(nut3) // [C, [B, [A]]], [D, [E]]
        mut.addChild(nut6) // [C, [B, [A]]], [D, [E]], [G, [F]]
        return mut
    }
    
    func testDescription() {
        let mut: Tree<String> = treeWithNodesPreInserted()
        NSLog("Description: \(mut)")
    }
    
    func testAddingNodeToTree() {
        mut.addChild(nut0)
        mut.addChild(nut1)
        
        XCTAssertEqual(mut.children.count, 2, "Should correctly add child to children")
        XCTAssert(nut0.parent === /* reference comparison */ mut, "Child should correctly reference parent")
        XCTAssertEqual(mut.children[0].depth, 1, "Child should have the correct depth")
    }
    
    func testIsEqual() {
        
        nut0.addChild(nut1)
        mut.addChild(nut0)
        
        NSLog("\(mut.children[0].children[0].value), \(nut1.value)")
        XCTAssertTrue(mut.children[0].children[0].isEquatable(to: nut1.value!))
    }
    
    func testDescendantCount() {
        let mut: Tree<String> = treeWithNodesPreInserted()
        XCTAssertEqual(mut.descendantCount, 7, "should correctly calculate descendants")
    }
    
    func testFlatten() {
        let mut: Tree<String> = treeWithNodesPreInserted()
        
        let expected: Array<String> = ["C", "B", "A", "D", "E", "G", "F"]
        XCTAssertEqual(mut.flatten, expected, "Tree should flatten correctly")
    }
    
    func testRetrieveNodeWithIdentifier() {
        let mut: Tree<String> = treeWithNodesPreInserted()
        
        let success: Tree<String> = nut6
        
        var test: Tree<String>?
        do {
            test = try mut.retrieveNodeWithIdentifier(nut6.value!)
        } catch {
            
        }
        XCTAssert(test === success, "Node should be the same")
    }
    
    func testInsertAfterNodeWithIdentifier() {
        let mut: Tree<String> = treeWithNodesPreInserted()
        
        let expected: Array<String> = ["C", "B", "A", "D", "Fuck Yea", "E", "G", "F"]
        
        let success = Tree<String>(withValue: "Fuck Yea")
        do {
            try mut.insertAfterNodeWithIdentifier("D", withTree: success, atIndex: 0)
        } catch {
            
        }
        
        XCTAssertEqual(mut.flatten, expected, "Tree should add nodes correctly")
    }
    
    func testRetrieveNodeWithIdentifierShouldThrow() {
        let mut: Tree<String> = treeWithNodesPreInserted()
        let invalidIdentifier = " Q"
        
        do {
            try mut.retrieveNodeWithIdentifier(invalidIdentifier)
            XCTFail("Call should have thrown an error")
        }
            
        catch {}
    }
    
    func testInsertAfterNodeWithIdentifierShouldThrow() {
        let mut: Tree<String> = treeWithNodesPreInserted()
        
        let irrelevant = Tree<String>(withValue: "Should Throw")

        let expected: Array<String> = ["C", "B", "A", "D", "E", "G", "F"]
        let invalidIdentifier = " Q"
        do {
            try mut.insertAfterNodeWithIdentifier(invalidIdentifier, withTree: irrelevant, atIndex: 0)
            XCTFail("Call should have thrown an error")
        }
        catch {}
        
        XCTAssertEqual(mut.flatten, expected, "Failing insert should not alter list")
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measureBlock {
            // Put the code you want to measure the time of here.
        }
    }

}

    /*

    var descendantCount: Int {
        var _cnt: Int = 0
        for child in self.children {
            if self.visible {
                _cnt += 1
                if child.children.count > 0 { _cnt += child.descendantCount }
            }
        }
        return _cnt
    }
    
    var indexInChildren: Int? {
        guard parent != nil else { return nil }
        return parent!.children.indexOf(self)
    }
    
    var hasChildren: Bool {
        return (self.children.count > 0)
    }
    
    // MARK: Functions; add / remove / flush / etc
    func flushCache() { flattenTreeWithCache(toBeFlushed: true) }
    
    
    func addChild(newChild: Tree, atIndex index: Int) {
        if self.depth != nil { newChild.depth = self.depth! + 1 }
        else { newChild.depth = 1 }
        newChild.parent = self
        self.children.insert(newChild, atIndex: index)
    }
    
        
    func addChild(newChild: Tree) {
        if self.depth != nil { newChild.depth = self.depth! + 1 }
        else { newChild.depth = 1 }
        newChild.parent = self
        self.children.append(newChild)
    }
    
    func flattenTreeWithCache(toBeFlushed flushing: Bool) -> [Tree] {
        var allTrees: [Tree] = []
        
        if flattenedTreeCache == nil || flushing {
            if flattenedTreeCache != nil { flattenedTreeCache = nil }
            for child in self.children {
                allTrees.append(child)
                allTrees += child.flattenTreeWithCache(toBeFlushed: flushing)
            }
            
            flattenedTreeCache = allTrees
        }
        
        return flattenedTreeCache!
    }
    
    func isEquatable(to val: T) -> Bool {
        guard self.value != nil else {
            return false
        }
        return self.value! == val
    }
    
    /* Iterates over children in a breadth-first fashion until childNode found, inserts at position
       Throws .TreeWithIdentifierNotFound if no suitable tree foujnd
    
    */
    func insertAfterNodeWithIdentifier(id: T, withTree tree: Tree, atIndex index: Int = 0) throws {
        if self.isEquatable(to: id) { self.addChild(tree) }
        
        var found = false
        let open = Dequeue<Tree>()
        open.dequeueOntoBottom(self)
        
        var closed = Set<Tree>()
        while !open.isEmpty {
            if let current = open.dequeueFromTop {
                closed.insert(current)
                for child in current.children where child.hasChildren {
                    if closed.contains(child) { continue }
                    
                    closed.insert(child)
                    
                    if id == child.value {
                        //Add node to child tree
                        child.addChild(tree, atIndex: index)
                        found = true
                        continue
                    }
                    
                    for next in child.children {
                        if !closed.contains(next) { open.dequeueOntoBottom(next) }
                    }
                }
            }
        }
        if !found { throw RedditClientError.ListingError.TreeWithIdentifierNotFound }
        else { flushCache() }
    }
}
*/