//
//  Stack.swift
//  RedditClient
//
//  Created by Travis Matthews on 11/29/15.
//  Copyright © 2015 Travis Matthews. All rights reserved.
//

import Foundation

class Stack<T>: NSObject {
    
    private var array: [T] = []
    
    var size: Int {
        return array.count
    }
    
    var isEmpty: Bool {
        return array.isEmpty
    }
    
    override init() {
        super.init()
    }
    
    // MARK: Stack Operations
    func push(value: T) {
        array.append(value)
    }
    
    func push(values: [T])   {
        for val in values {
            array.append(val)
        }
    }
    
    var pop: T? {
        guard !array.isEmpty else {
            return nil
        }
        
        let val = array.removeLast()
        return val
    }
}


class IntelligentStack<T>: Stack<T> {
    var notification: String
    
    init(stackPreparedMessage: String) {
        notification = stackPreparedMessage
        super.init()
    }
    
    // MARK: Stack Operations; will post notification when filled
    override func push(value: T) {
        array.append(value)
        NSNotificationCenter.defaultCenter().postNotificationName(notification, object: nil)
    }
    
    override func push(values: [T])   {
        for val in values {
            array.append(val)
        }
        
        NSNotificationCenter.defaultCenter().postNotificationName(notification, object: nil)
    }
}
