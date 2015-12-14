//
//  CommentTree.swift
//  RedditClient
//
//  Created by Travis Matthews on 12/11/15.
//  Copyright © 2015 Travis Matthews. All rights reserved.
//

import Foundation


class CommentTree {
    var tree: Tree<CommentData>?
    
    init?(json: [String: AnyObject]) {
        if let tree = initTreeWithJson(json) {
            self.tree = tree
            return
        }
        return nil
    }
    
    /* A Depth First Traversal of the prospective comment tree */
    func initTreeWithJson(json: [String: AnyObject]) -> Tree<CommentData>? {
        
        let tree : Tree<CommentData> = Tree<CommentData>()
        typealias Stage = (tree: Tree<CommentData>, rawJson: [String: AnyObject])
        let open: Stack<Stage> = Stack<Stage>()
        
        /* I need to split the json into init array; add to tree as children */
        let currentStage = Stage(tree, json)
        open.push(currentStage)
        
        while !open.isEmpty {
            let currentStage = open.pop!
            let node = currentStage.tree
            let parse = Parse(withJson: currentStage.rawJson)
            
            switch parse.resultType {
            case .Listing(let replies):
                for newChildJson in replies/*.reverse()*/ {
                    let nextTree = Tree<CommentData>()
                    let nextState = Stage(nextTree, newChildJson)
                    node.addChild(nextTree)
                    open.push(nextState)
                }
                
            case .Comment(let comment, let replies):
                node.value = comment
                if replies.count > 0 {
                    for newChildJson in replies/*.reverse()*/ {
                        let nextTree = Tree<CommentData>()
                        let nextState = Stage(nextTree, newChildJson)
                        node.addChild(nextTree)
                        open.push(nextState)
                    }
                }
                
            case .More(let more):
                node.value?.addReplies(more)
            
            case .Error(let error):
                print("\(error)")
                fatalError()
            default: continue
            }
        }
        return tree
    }
}