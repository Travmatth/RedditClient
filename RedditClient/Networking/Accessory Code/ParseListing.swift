//
//  ParseListing.swift
//  RedditClient
//
//  Created by Travis Matthews on 12/6/15.
//  Copyright © 2015 Travis Matthews. All rights reserved.
//

import Foundation

class ParseListing {
    //MARK: Class lifecycle
    init(dataFromNetworking: NSData) {
        self.json = JSON(data: dataFromNetworking)
        startParse()
    }
    
    //MARK: Class variables
    let json: JSON!
    var post: PostData?
    var comments: Tree<CommentData> = Tree<CommentData>()
    
    //MARK: Class parsing func's
    func startParse() {
        if (json[0].isExists() && json[1].isExists()) {
            // Parse head and tail
            post = PostData(json: json[0])
            print("sent data to post")
            parseComments(json[1])
        }
    }
    
    func parseComments(json: JSON) {
    }
}

