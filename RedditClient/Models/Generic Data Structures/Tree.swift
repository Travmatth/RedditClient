//
//  TreeNode.swift
//  RedditClient
//
//  Created by Travis Matthews on 12/5/15.
//  Copyright © 2015 Travis Matthews. All rights reserved.
//

import Foundation


/* 
    When T is equatable, comparison for like items is easier
    http://nshipster.com/swift-default-protocol-implementations/
    http://stackoverflow.com/questions/33189018/extend-existing-generic-swift-class-to-be-hashable
*/
func == <T: Equatable> (lhs: Tree<T>, rhs: Tree<T>) -> Bool { return unsafeAddressOf(lhs) == unsafeAddressOf(rhs) }


class Tree<T: Equatable>: Hashable  {
    
    // MARK: Lifecycle Methods
    init() {}
    deinit { print("tree node being lost") }
    
    init(withValue val: T) { self.value = val }
    
    // MARK: Lifecycle Methods + Hashable Conformance; Needed so that self may be added to a set
    /**/
    var uid: Int?
    var hashableName: String?
    
    init(uid: Int, name: String) {
        self.uid = uid
        self.hashableName = name
    }
    
    var hashValue: Int {
        if let _uid = self.uid { return _uid }
        return 0
    }
    
    // MARK: Class Variables
    var value: T?
    var depth: Int = 0
    var parent: Tree?
    var visible: Bool = true
    var children: [Tree] = []
    var flattenedTreeCache: [Tree]?

    // MARK: Computed properties; mostly queries on the children
    var flatten: [T] { return flattenTreeWithCache(toBeFlushed: false).flatMap() { $0.value } }
    
    var isRoot: Bool { if self.parent == nil { return true } else { return false } }
    
    var descendants: [Tree]? {
        guard self.children.count > 0 else { return [] }
        return self.children
    }
    
    var descendantCount: Int {
        var _cnt: Int = 0
        for child in self.children {
            if child.visible {
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
    
    /* not being accessed? */
    var description: String {
        NSLog("Description accessed")
        var _location: [String] = []
        if let value = value as? String { return value }
        else {
            var next = self
            while !next.isRoot {
                _location.append("depth: \(self.depth) index: \(self.indexInChildren)")
                next = next.parent!
            }
            _location.append("root")
        }
        return _location.reverse().joinWithSeparator(" ")
    }
    
    // MARK: Functions; add / remove / flush / etc
    func flushCache() { flattenTreeWithCache(toBeFlushed: true) }
    
    func flushCacheAndAncestors() {
        var next = self
        while !next.isRoot {
            self.flatten
            next = self.parent!
        }
    }
    
    
    func addChild(newChild: Tree, atIndex index: Int) {
        newChild.parent = self
        newChild.depth = self.depth + 1
        self.children.insert(newChild, atIndex: index)
    }
    
        
    func addChild(newChild: Tree) {
        newChild.parent = self
        newChild.depth = self.depth + 1
        self.children.append(newChild)
    }
    
    func flattenTreeWithCache(toBeFlushed flushing: Bool) -> [Tree] {
        var allTrees: [Tree] = []
        
        if (flattenedTreeCache == nil || flushing) {
            if (flattenedTreeCache != nil) { flattenedTreeCache = nil }
            for child in self.children  where (child.visible == true) {
                allTrees.append(child)
                allTrees += child.flattenTreeWithCache(toBeFlushed: flushing)
            }
            
            flattenedTreeCache = allTrees
        }
        
        return flattenedTreeCache!
    }
    
    func isEquatable(to val: T) -> Bool {
        guard (self.value != nil) else {
            return false
        }
        return self.value! == val
    }
    /* Iterates over children in a breadth-first fashion until childNode found, retrieves
       Throws .TreeWithIdentifierNotFound if no suitable tree found
    
    */
    func retrieveNodeWithIdentifier(id: T) throws -> Tree  {
        if self.isEquatable(to: id) { return self }
        
        let open = Dequeue<Tree>()
        var closed = Set<Tree>()
        
        open.dequeueOntoBottom(self)
        
        while !open.isEmpty {
            if let current = open.dequeueFromTop {
                closed.insert(current)
                for child in current.children where child.hasChildren {
                    if (closed.contains(child)) { continue }
                    
                    closed.insert(child)
                    
                    if id == child.value {
                        return child
                    }
                    
                    for next in child.children {
                        if !closed.contains(next) { open.dequeueOntoBottom(next) }
                    }
                }
            }
        }
        
        throw RedditClientError.ListingError.TreeWithIdentifierNotFound
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
                    if (closed.contains(child)) { continue }
                    
                    closed.insert(child)
                    
                    if id == child.value {
                        child.addChild(tree, atIndex: index)
                        child.flushCacheAndAncestors()
                        found = true
                        return
                    }
                    
                    for next in child.children {
                        if !closed.contains(next) { open.dequeueOntoBottom(next) }
                    }
                }
            }
        }
        
        if !found { throw RedditClientError.ListingError.TreeWithIdentifierNotFound }
    }
    
    /* Iterates over children in a breadth-first fashion until childNode found, inserts at position
       Throws .TreeWithIdentifierNotFound if no suitable tree foujnd
    */
    func modifyNodeWithIdentifier(id: T, completion: Tree -> Void) throws {
        if self.isEquatable(to: id) { completion(self) }
        
        var found = false
        let open = Dequeue<Tree>()
        open.dequeueOntoBottom(self)
        
        var closed = Set<Tree>()
        while !open.isEmpty {
            if let current = open.dequeueFromTop {
                closed.insert(current)
                for child in current.children where child.hasChildren {
                    if (closed.contains(child)) { continue }
                    
                    closed.insert(child)
                    
                    if id == child.value {
                        //Add node to child tree
                        completion(self)
                        child.flushCacheAndAncestors()
                        found = true
                        return
                    }
                    
                    for next in child.children {
                        if !closed.contains(next) { open.dequeueOntoBottom(next) }
                    }
                }
            }
        }
        
        if !found { throw RedditClientError.ListingError.TreeWithIdentifierNotFound }
    }
}