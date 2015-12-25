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
    var flatten: [CommentData]? {
        return tree?.flatten
    }
    
    init?(json: [String: AnyObject]) {
        if let tree = initTreeWithJson(json) {
            self.tree = tree
            return
        }
        return nil
    }
    
    /* A Depth First creation of the prospective comment tree from received Json */
    func initTreeWithJson(json: [String: AnyObject]) -> Tree<CommentData>? {
        
        let root : Tree<CommentData> = Tree<CommentData>()
        typealias Stage = (tree: Tree<CommentData>, rawJson: [String: AnyObject])
        let open: Stack<Stage> = Stack<Stage>()
        
        open.push(Stage(root,json))
        
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
                /*
                Move "more" to own node, implement common
                HasIdentity protocol for comparison purposes
                btw More & Comment nodes

                let nextTree = Tree<CommentData>()
                node.addChild(nextTree)
                */
                node.value?.addReplies(more)

            case .Error(let error):
                print("failed to create comment tree: \(error)")
            default: continue
            }
        }
        return root
    }
}