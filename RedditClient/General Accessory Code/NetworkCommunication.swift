//
//  ListingsViewController.swift
//  RedditClient
//
//  Created by Travis Matthews on 11/10/15.
//  Copyright © 2015 Travis Matthews. All rights reserved.
//

import UIKit

protocol NetworkCommunication { }
extension NetworkCommunication {
    struct Networking {
        static var session: Session! {
    }
        
    var session: Session! {
        get {
            return objc_getAssociatedObject(self, &Networking.session)
        }
    }
}

