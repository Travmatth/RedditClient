//
//  Recommender.swift
//  RedditClient
//
//  Created by Travis Matthews on 11/29/15.
//  Copyright © 2015 Travis Matthews. All rights reserved.
//

import Foundation

protocol Recommender {
    var next: Recommendation? { get }
}