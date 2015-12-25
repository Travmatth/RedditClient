//
//  CommentTableModel.swift
//  RedditClient
//
//  Created by Travis Matthews on 12/25/15.
//  Copyright © 2015 Travis Matthews. All rights reserved.
//

import UIKit
import Foundation

class CommentTableModel: NSObject {
    var tree: CommentTree?
    init?(fromCommentTree tree: CommentTree?) {
        self.tree = tree
        return
    }
}

extension CommentTableModel: UITableViewDataSource {
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CommentCell") //as? RedditPostCommentTableViewCell
        //cell?.frame = CGRect(x: 0, y: 0, width: 320, height: 44)
        //cell?.test("is this working")
        cell?.textLabel?.numberOfLines = 0
        cell?.textLabel?.lineBreakMode = .ByWordWrapping
        cell?.textLabel?.text = tree?.flatten?[indexPath.row].body
        
        return cell!
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tree?.flatten?.count ?? 0
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
}

extension CommentTableModel: UITableViewDelegate {
    /*
    func tableView(tableView: UITableView, indentationLevelForRowAtIndexPath indexPath: NSIndexPath) -> Int {
        fataError("Not Implemented Yet")
    }
    */
}