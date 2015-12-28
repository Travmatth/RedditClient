//
//  File.swift
//  RedditClient
//
//  Created by Travis Matthews on 12/25/15.
//  Copyright © 2015 Travis Matthews. All rights reserved.
//

import UIKit
import Foundation

class CommentTableView: UITableView {
    
    //MARK: UITableViewDataSource
    var tree: CommentTree?
    var post: PostData!
    
    func configure() {
        self.registerClass(RedditPostCommentTableViewCell.self, forCellReuseIdentifier: "CommentCell")
        
        let recognizeLeft = UISwipeGestureRecognizer.init(target: self, action: "handleSwipeLeft:")
        let recognizeRight = UISwipeGestureRecognizer.init(target: self, action: "handleSwipeRight:")
        
        recognizeLeft.direction = .Left
        recognizeLeft.direction = .Right
        
        self.addGestureRecognizer(recognizeLeft)
        self.addGestureRecognizer(recognizeRight)
    }
    
    func handleSwipeLeft(gestureRecognizer: UISwipeGestureRecognizer) {
        //Location of swipe
        let location: CGPoint = gestureRecognizer.locationInView(self)
        
        //Corresponding indexPath of swipe 
        if let indexPath: NSIndexPath = self.indexPathForRowAtPoint(location),
               _ = self.cellForRowAtIndexPath(indexPath) as? RedditPostCommentTableViewCell {
                print("swipe left")
            }
    }
    
    func handleSwipeRight(gestureRecognizer: UISwipeGestureRecognizer) {
        //Location of swipe
        let location: CGPoint = gestureRecognizer.locationInView(self)
        
        //Corresponding indexPath of swipe 
        if let indexPath: NSIndexPath = self.indexPathForRowAtPoint(location),
               _ = self.cellForRowAtIndexPath(indexPath) as? RedditPostCommentTableViewCell {
                print("swipe right")
            }
    }
}

extension CommentTableView: UITableViewDataSource {
    /*
    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        return PostViewManager.configurePostViewWithData(post, inViewController: self)
    }
    */
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCellWithIdentifier("CommentCell") as? RedditPostCommentTableViewCell
        
        cell?.configureCell(fromComment: tree?.flatten?[indexPath.row])
        cell?.layoutIfNeeded()
        
        return cell!
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tree?.flatten?.count ?? 0
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
}

extension CommentTableView: UITableViewDelegate {
    func tableView(tableView: UITableView, estimatedHeightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        let cell = tableView.dequeueReusableCellWithIdentifier("CommentCell") as? RedditPostCommentTableViewCell
        cell?.configureCell(fromComment: tree?.flatten?[indexPath.row])
        let size = cell?.contentView.systemLayoutSizeFittingSize(UILayoutFittingCompressedSize)
        return size?.height ?? 100.0
    }
    /*
    func tableView(tableView: UITableView, indentationLevelForRowAtIndexPath indexPath: NSIndexPath) -> Int {
        fataError("Not Implemented Yet")
    }
    */
}