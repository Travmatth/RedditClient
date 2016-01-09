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
    
    var size: Int { return array.count }
    
    var isEmpty: Bool { return array.isEmpty }
    
    override init() { super.init() }
    
    // MARK: Stack Operations
    func push(value: T) { array.append(value) }
    
    func push(values: [T])   {
        for val in values { array.append(val) }
    }
    
    var pop: T? {
        guard !array.isEmpty else { return nil }
        return array.removeLast()
    }
}