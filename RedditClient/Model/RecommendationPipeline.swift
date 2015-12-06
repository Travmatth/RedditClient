//
//  File.swift
//  RedditClient
//
//  Created by Travis Matthews on 11/26/15.
//  Copyright © 2015 Travis Matthews. All rights reserved.
//

import Foundation

/*
    RecommendationEngine provides recommendations for subreddits the user may be interested in

    The recommendation engine at it's core is two dequeues
    dequeue 1: Recommendation Source
    - scrapes users link and post karma across all subreddits to find the subreddits they are most active in
    dequeue 2: Recommendation Pipeline
    - uses source dequeue to maintain a list of recommendations

class RecommendationEngine: NSObject, NetworkCommunication {
    var session: Session! = Session.sharedInstance
}
*/



//session should conform to this
protocol RecommendationAPI {
    //API Call: Get user karma breakdown
    //API Call: Given recommended subreddit, get recommended subreddit -> ONLY REPEAT UNTIL 20 SUBS
    // Both should be able to handle multiple callbacks; one to cache subreddit results, one to load initial subreddit results
    // - Iterative? ex, a param: apiCallsRemaining: 20 - 1 for  each successive call
}

typealias Seed = String
typealias Recommendation = String

class RecommendationEngine: NSObject, Recommender, NetworkCommunication {
    
    // .postNotificationName chain: login -> create seeds -> consume seeds into recommendation
    private let threshold: Int = 20 //How many recommendations should I keep on hand?
    weak var session: Session! = Session.sharedInstance
    //private var recommendations = Stack<Recommendation>()
    private var recommendations: [Recommendation] = []
    private var seeds = IntelligentStack<Seed>(stackPreparedMessage: "SeedStackReady")
    
    /*
    var next: Recommendation? {
        return recommendations.pop
    }
    */
    
    func retrieveRecommendations(onCompletion: [Recommendation] -> Void) {
        onCompletion(recommendations)
    }
    
    func shouldSeekSeeds(_: NSNotification) {
        session!.user?.getSubreddits() { newSeed in
            self.seeds.push(newSeed)
        }
    }
    
    func shouldSeekRecommendations(_: NSNotification) {
        //fatalError("If no subscriptions, no seed values to push")
        // If recommendations needed and seeds available
        if (recommendations.count < threshold) && (recommendations.count <= seeds.size) {
            var recommendationsNeeded: [Recommendation] = []
            for _ in 0..<(threshold - recommendations.count) {
                if let nextRecommendation = seeds.pop { recommendationsNeeded.append(nextRecommendation) }
            }
            session.addRecommendations(recommendationsNeeded) { newRecommendations in
                self.recommendations += newRecommendations
            }
        }
    }
    
    // MARK: Class lifecycle events
    override init() {
        super.init()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "shouldSeekRecommendations:", name: "SeedStackReady", object: nil)
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "shouldSeekSeeds:", name: "SubredditsListReady", object: nil)
    }
    
    deinit { NSNotificationCenter.defaultCenter().removeObserver(self) }
}
