//
//  Response.swift
//  reddift
//
//  Created by sonson on 2015/06/26.
//  Copyright © 2015年 sonson. All rights reserved.
//

import Foundation

/**
 Object to eliminate codes to parse http response object.
 */
struct Response {
    let data:NSData
    let statusCode:Int
    
    init(data: NSData!, urlResponse: NSURLResponse!) {
        if let data = data {
            self.data = data
            let string = NSString.init(data: data, encoding: NSUTF8StringEncoding)
            NSLog("data: \(string)")
        }
        else {
            self.data = NSData()
        }
        if let httpResponse = urlResponse as? NSHTTPURLResponse {
            statusCode = httpResponse.statusCode
            NSLog("status code: \(statusCode)")
        }
        else {
            statusCode = 500
        }
    }
}