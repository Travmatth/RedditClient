//
//  ListingsViewController.swift
//  RedditClient
//
//  Created by Travis Matthews on 11/10/15.
//  Copyright © 2015 Travis Matthews. All rights reserved.
//

import UIKit

class ListingsViewController: UITableViewController {
    var apiManager: APIManager!
    
    // Find retain cycles!
    deinit {
        NSLog("LoginViewController.deinit")
    }
}
