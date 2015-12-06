//
//  TreeNode.swift
//  RedditClient
//
//  Created by Travis Matthews on 12/5/15.
//  Copyright © 2015 Travis Matthews. All rights reserved.
//

import Foundation


/* http://nshipster.com/swift-default-protocol-implementations/
http://stackoverflow.com/questions/33189018/extend-existing-generic-swift-class-to-be-hashable
*/

func ==<T: Equatable> (lhs: Tree<T>, rhs: Tree<T>) -> Bool { return unsafeAddressOf(lhs) == unsafeAddressOf(rhs) }


class Tree<T: Equatable>: Hashable  {
    
    // MARK: Operators
    /* Normally I detest custom operators for their added mental complexity
    But I must if i'm to implement equatable on self
    */
    // MARK: Lifecycle Methods
    init() {}
    
    init(withValue val: T) { self.value = val }
    
    // MARK: Lifecycle Methods + Hashable Conformance
    var uid: Int?
    var hashableName: String?
    init(uid: Int, name: String) {
        self.uid = uid
        self.hashableName = name
    }
    
    var hashValue: Int {
        if let _uid = self.uid {
            return _uid
        }
        return 0
    }
    
    // MARK: Class Variables
    var value: T?
    var depth: Int?
    var parent: Tree?
    var isRoot = false
    var visible: Bool = false
    var children: [Tree] = []
    var flattenedTreeCache: [Tree]?

    // MARK: Computed properties; mostly queries on the children
    var flatten: [T] { return flattenTreeWithCache(toBeFlushed: false).flatMap() { $0.value } }
    
    var description: String {
        guard value != nil else { return "Error" }
        if let value = value as? String { return value }
        fatalError("Need to implement an actual description")
    }
    
    var descendants: [Tree]? {
        guard self.children.count > 0 else {
            return []
        }
        return self.children
    }
    
    var descendantCount: Int {
        var _cnt: Int = 0
        for child in self.children {
            if self.visible {
                _cnt += 1
                if child.children.count > 0 {
                    _cnt += child.descendantCount
                }
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
        var allComments: [Tree] = []
        
        if flattenedTreeCache == nil || flushing {
            if flattenedTreeCache != nil { flattenedTreeCache = nil }
            for child in self.children {
                allComments.append(child)
                allComments += child.flattenTreeWithCache(toBeFlushed: flushing)
            }
            
            flattenedTreeCache = allComments
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
    func insertAfterNodeWithIdentifier(id: T, withTree tree: Tree, atIndex index: Int = 0) /*throws*/ {
        if self.isEquatable(to: id) { self.addChild(tree) }
        
        let open = Dequeue<Tree>()
        open.dequeueOntoBottom(self)
        
        var closed = Set<Tree>()
        while !open.isEmpty {
            if let current = open.dequeueFromTop {
                closed.insert(current)
                for child in current.children where child.hasChildren {
                    if closed.contains(child) {
                        continue
                    }
                    closed.insert(child)
                    if id == child.value {
                        //Add node to child tree
                        child.addChild(tree, atIndex: index)
                        
                    }
                    for _child in child.children {
                        if !closed.contains(_child) {
                            open.dequeueOntoBottom(_child)
                        }
                    }
                }
            }
        }
        //fatalError("Need to implement throw if not found")
        //throw RedditClientError.ListingError.TreeWithIdentifierNotFound
    }
}