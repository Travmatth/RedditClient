//
//  IntelligentStack.swift
//  RedditClient
//
//  Created by Travis Matthews on 11/27/15.
//  Copyright © 2015 Travis Matthews. All rights reserved.
//

import Foundation

/*
I wish there was a way to combine protocols with observers:

extension Stack: WillDemandItems {
    override func push(value: T) posts<"StackLow"> -> Void {}
*/


// (([(String, Int)]))
class IntelligentStack<T> {
    var notification: String
    private var array: [T] = []
    
    init(stackPreparedMessage: String) {
        notification = stackPreparedMessage
    }
    
    var size: Int {
        return array.count
    }
    
    var isEmpty: Bool {
        return array.isEmpty
    }
    
    var pop: T? {
        guard !array.isEmpty else {
            return nil
        }
        
        let val = array.removeLast()
        return val
    }
    
    // MARK: Stack Operations; will post notification when filled
    func push(value: T) {
        array.append(value)
        NSNotificationCenter.defaultCenter().postNotificationName(notification, object: nil)
    }
    
    func push(values: [T])   {
        for val in values {
            array.append(val)
        }
        
        NSNotificationCenter.defaultCenter().postNotificationName(notification, object: nil)
    }
}