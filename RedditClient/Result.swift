//
//  Result.swift
//  RedditClient
//
//  Created by Travis Matthews on 11/12/15.
//  Copyright © 2015 Travis Matthews. All rights reserved.
//
//  https://github.com/sonsongithub/reddift/blob/master/reddift/Utility/Result.swift

import Foundation

public enum Result<A> {
    case Success(A)
    case Failure(String)
    
    init(value: A) {
        self = .Success(value)
    }
    
    init(error: String) {
        self = .Failure(error)
    }
    
    // Conditionally returns some item B if self (set initially by optionaError / resultFromOptionalError is .Success ; workhorse of flatMap
    // H:(f:A->B), (g:C->B) -> B
    func package<B>(@noescape ifSuccess ifSuccess: A -> B, @noescape ifFailure: String -> B) -> B {
        switch self {
            
        case .Success(let value):
            return ifSuccess(value)
            
        case .Failure(let value):
            return ifFailure(value)
        }
    }
    
    func map<B>(@noescape transform: A -> B) -> Result<B> {
        return flatMap { .Success(transform($0)) }
    }
    
    func flatMap<B>(@noescape transform: A -> Result<B>) -> Result<B> {
        return package(ifSuccess: transform, ifFailure: Result<B>.Failure)
    }
    
    var error: String? {
        switch self {
            
        case .Failure(let error):
            return error
            
        default:
            return nil
        }
    }
    
    var value: A? {
        switch self {
        case .Success(let success):
            return success
            
        default:
            return nil
        }
    }
}

func resultFromOptionalError<A>(value: A, optionalError: NSError? ) -> Result<A> {
    if let error = optionalError {
        return .Failure("\(error)")
    } else {
        return .Success(value)
    }
}

/**
    resultFromOptional Example:

    // creat datatask
    let task = session.dataTaskWithRequest(request, completionHandler: { (data:NSData?, response:NSURLResponse?, error:NSError?) -> Void in

    // resultFromOptional unwraps the error and creates .failure enum, if no error then .success enum
    // .flatMap is called on the enum, it's passed the response2Data func, which creates fail or success enum in response to statuscode of request
    // .flatmap then called on data2json, which creates either .Success ([String: AnyObject] or [AnyObject]) or .Failure(code)
    // .flatMap then passed a closure to  convert JSON in [String: AnyObject]
    let result = resultFromOptionalError(Response(data: data, urlResponse: response), optionalError:error).flatMap(response2Data).flatMap(data2Json).flatMap({(json:JSON) -> Result<[String:AnyObject]> in
        if let json = json as? [String:AnyObject] {
            return Result(value: json)
        }
        return Result(error: ReddiftError.Malformed.error)
    })
    // with prior func complete, result now equals a .success enum w/ json = [string: anyobject]
    switch result {
    case .Success(let json):
        // ...
    case .Failure(let error):
        completion(Result(error: error))
    }
*/