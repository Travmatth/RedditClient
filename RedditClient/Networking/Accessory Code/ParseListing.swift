//
//  ParseListing.swift
//  RedditClient
//
//  Created by Travis Matthews on 12/6/15.
//  Copyright © 2015 Travis Matthews. All rights reserved.
//

import Foundation

typealias JsonDict = Dictionary<String, JSON>
class ParseListing {
    //MARK: Class lifecycle
    init(dataFromNetworking: NSData) {
        self.json = JSON(data: dataFromNetworking)
        
        startParse(self.json/*.array*/)
    }
    
    //MARK: Class variables
    let json: JSON!
    var post: PostData?
    var comments: Tree<CommentData> = Tree<CommentData>()
    var root: [JSON]!
    
    //MARK: Class parsing func's
    func startParse(json: JSON) {
        let head = json.array?[0].dictionary
        let tail = json.array?[1].dictionary
        
        if (head != nil && tail != nil) {
            print("startparse called")
            // Parse head and tail
            post = PostData(json: head!)
            print("sent data to post")
            parseComments(tail!)
        }
    }
    
    func parseComments(json: JsonDict) {
    }
}

