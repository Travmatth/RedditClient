//
//  Filters.swift
//  RedditClient
//
//  Created by Travis Matthews on 11/20/15.
//  Copyright © 2015 Travis Matthews. All rights reserved.
//

import Foundation


func acceptableStatusCode(response: Response) -> Result<NSData> {
    let successRange = 200..<300
    
    if !successRange.contains(response.statusCode) {
        return .Failure("status code of \(response.statusCode) outside of bounds")
    }
    
    return .Success(response.data)
}

func fromDataToJSON(data: NSData) -> Result<AnyObject> {
    do {
        let json = try NSJSONSerialization.JSONObjectWithData(data, options: [])
        return Result(value: json)
    } catch {
        return Result(error: "Failure while parsing JSON inside fromDataToJSON")
    }
}

func fromJSONToMulti(json: AnyObject) -> Result<Any> {
    var multiReddits = [Multi]()
    
    if let jsonArray = json as? NSArray {
        for child in jsonArray {
            
            if let kind = child["kind"] as? String {
                if kind == "LabeledMulti" {
                    if let data = child["data"] as? NSDictionary {
                        
                        var subscriptions = [String]()
                        
                        let name = data["name"] as! String
                        let displayName = data["display_name"] as! String
                        let descriptionHTML = data["description_html"] as! String
                        
                        if let subs = data["subreddits"] as? NSArray {
                            for sub in subs { subscriptions.append(sub["name"] as! String) }
                            
                        multiReddits.append(Multi(subscriptions, descriptionHTML, displayName, name))
                        }
                    }
                }
            }
        }
    }
    
    return Result(value: multiReddits)
}

func fromDataToJSONArray(data: NSData) -> Result<AnyObject> {
    do {
        let json = try NSJSONSerialization.JSONObjectWithData(data, options: NSJSONReadingOptions.MutableContainers)
        return Result(value: json)
    } catch {
        return Result(error:"Failed to convert JSON to NSArray")
    }
}