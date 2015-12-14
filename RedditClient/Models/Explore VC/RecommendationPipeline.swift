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
        fatalError("Refactor")
        /*
        nhgrif: basically my session class handles all networking for the app. i want session to be able to query reddit's api with a subreddit, and have the recommended subreddit it return added into an array which is then available to the viewcontroller
        
        
        the trick becomes that i need to make an individual request for each subreddit i want recommendations to
        
        So, for a given subreddit, you need to fetch the recommended subreddit?
        
        exactly
        
        
        but i can't send in all the given subreddits at once
        
        No... but calm down. You can't eat the whole elephant all at once.
        
        
        ;)
        
        
        You should have a method which simply does what I just said. Takes a subreddit as an argument and returns the recommended subreddit as a response.
        
        
        And build from there, right?
        
         
        
        So, the API response gives you not a single recommended subreddit, but rather an array of all of the recommended subreddits
        
        
        Maybe, but the code is probably asynchronous
        
        
        so it's probably more like this...
        
        yup. the trick is that it looks as though i have to query the api individually, since sending in multiple requests returns the set of intersecting recommendations (which would be 0)
        
         
        
        redditWebService.fetchRecommendations(subReddit) { recommendations, error in
        if let recommendations = recommendations {
            allRecommendations.append(recommendations)
            } else {
                print(error)
            }
        }
        
        
        for subReddit in subReddits {
        // do that fetch code from above
        }
        
        
        nhgrif: and that was my dilemma - i need to wait until all api calls are completed to return the data, but i had no way to know how much data the final array would be so no way to know when it was ultimately finished - except by posting an nsnotification on the last request
        
        Well, a couple of things...
        
        
        1) You probably shouldn't be posting a notification... just a guess.
        
        
        2) You probably shouldn't care whether or not the callback that just happened was the last one or not...
        
        
        Update the UI on every call back.
        */
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
