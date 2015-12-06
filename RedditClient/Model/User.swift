//
//  User.swift
//  RedditClient
//
//  Created by Travis Matthews on 11/27/15.
//  Copyright © 2015 Travis Matthews. All rights reserved.
//

import Foundation
class User: NSObject, NetworkCommunication {
    
    weak var session: Session!
    
    var state: State
    var oauthToken: OAuthToken?
    var karmaBreakDown: [Karma] = []    // Karma(subreddit: String, commentKarma: Int, linkKarma: Int)
    
    enum State {
        case User
        case Guest
    }
    
    // Mark: RecommendationEngine functionality
    func getSubredditKarmaListings(_: NSNotification) {
        if oauthToken != nil {
            session!.getUsernameKarma() { karmaListing in
                self.karmaBreakDown = karmaListing
                NSNotificationCenter.defaultCenter().postNotificationName("SubredditsListReady", object: nil)
            }
        }
    }
    
    func getSubreddits(onCompletion: ([Recommendation]) -> Void) {
        onCompletion(karmaBreakDown.map( { $0.subreddit } ))
    }
    
    // MARK: Lifecycle Methods
    init(session: Session?, state: State, token: OAuthToken) {
        self.state = state
        self.session = session
        self.oauthToken = token
        
        super.init()
        
        NSNotificationCenter.defaultCenter().addObserver(self, selector: "getSubredditKarmaListings:", name: "SuccessfulLogin", object: nil)
    }
    
    
    deinit { NSNotificationCenter.defaultCenter().removeObserver(self) }
}

/* Do i want to implement this?

                //self.user = User(OAuthToken(json: object as? Dictionary<String, AnyObject>)
                self.oauthToken = OAuthToken(json: object as? Dictionary<String, AnyObject>)
                //self.oauthToken = OAuthToken(accessToken, tokenType, expiresIn, refreshToken, scopes)
                self.oauthToken!.save()
                NSNotificationCenter.defaultCenter().postNotificationName("SuccessfulLogin", object: nil)

received in the api call for username in recommendationpipeline
has_mail	:	false

name	:	another_test_acct

created	:	1447203562

hide_from_robots	:	false

gold_creddits	:	0

created_utc	:	1447174762

has_mod_mail	:	false

link_karma	:	1

comment_karma	:	0

over_18	:	true

is_gold	:	false

is_mod	:	false

id	:	rwuhe

gold_expiration	:	null

inbox_count	:	0

has_verified_email	:	false

is_suspended	:	false

suspension_expiration_utc	:	null
d
*/