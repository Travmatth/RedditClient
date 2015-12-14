//
//  Dequeue.swift
//  RedditClient
//
//  Created by Travis Matthews on 12/6/15.
//  Copyright © 2015 Travis Matthews. All rights reserved.
//

import Foundation

class Dequeue<T> {
    
    private var array: [T] = []
    
    // Mark: Lifecycle
    init() {}
    
    var size: Int {
        return array.count
    }
    
    var isEmpty: Bool {
        return array.isEmpty
    }
    
    // MARK: Stack Operations
    func dequeueOntoBottom(value: T) {
        array.append(value)
    }
    
    func push(values: [T])   {
        for val in values {
            array.append(val)
        }
    }
    
    var dequeueFromTop: T? {
        guard !array.isEmpty else {
            return nil
        }
        
        let val = array.removeAtIndex(0)
        return val
    }
}