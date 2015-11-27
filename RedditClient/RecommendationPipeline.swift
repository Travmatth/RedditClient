//
//  File.swift
//  RedditClient
//
//  Created by Travis Matthews on 11/26/15.
//  Copyright © 2015 Travis Matthews. All rights reserved.
//

import Foundation


class RecommendationEngine: NSObject, NetworkCommunication {
    
    override init() {
        super.init()
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "startRecommendations:", name: "Successful Login", object: nil)
    }
    
    deinit {
        NSNotificationCenter.defaultCenter().removeObserver(self)
    }
    
    var session: Session! = Session.sharedInstance
    let deq = Dequeue<String>()
    
    internal var nextRecommendation: String? {
        NSLog("nextRecommendation called")
        return rationedWithdrawal()
    }
    
    private func rationedWithdrawal() -> String? {
        if deq.size <= 2 {
            findRecommendations()
        }
        
        let nextRecommendation = deq.dequeueFromTop()
        return nextRecommendation?.key
    }
    
    func startRecommendations(notification: NSNotification) {
        findRecommendations()
    }
    
    private func findRecommendations() {
        session.getRecommendations() { (recommendations) in
            for subreddit in recommendations {
                self.deq.enqueue(subreddit)
            }
        }
    }
}