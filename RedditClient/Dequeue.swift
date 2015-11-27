//
//  Dequeue.swift
//  RedditClient
//
//  Created by Travis Matthews on 11/27/15.
//  Copyright © 2015 Travis Matthews. All rights reserved.
//

import Foundation

class Node<T> {
    var key: T?
    weak var next: Node<T>?
    weak var previous: Node<T>?
    
    init(key: T, previous: Node? = nil) {
        self.key = key
        self.previous = previous
    }
}


class Dequeue<T> {
    private var count: Int = 0
    private weak var top: Node<T>?
    private weak var bottom: Node<T>?
    
    var size: Int {
        return count
    }
    
    func enqueue(val: T) {
        // if dequeue is empty
        let node = Node(key: val)
        
        if top == nil {
            self.top = node
            self.bottom = node
        } else {
            self.bottom?.next = node
            self.bottom = node
        }
        
        count++
    }
    
    func dequeueFromTop() -> Node<T>? {
        guard self.top != nil else {
            return nil
        }
        
        guard self.top?.next != nil else {
            let node = self.top
            self.top = nil
            
            return node
        }
        
        let node = top
        top = node?.next
        return top
    }
    
    func dequeueFromBottom() -> Node<T>? {
        guard self.bottom != nil else {
            return nil
        }
        
        guard self.bottom?.previous != nil else {
            let node = self.bottom
            self.bottom = nil
            return node
        }
        
        let node = top
        top = node?.next
        return top
        
    }
}