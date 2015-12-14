//
//  Result.swift
//  reddift
//
//  Created by sonson on 2015/05/06.
//  Copyright (c) 2015年 sonson. All rights reserved.
//

import Foundation

public enum Result<A> {
    case Success(A)
    case Failure(ErrorType)
    
    public init(value:A) {
        self = .Success(value)
    }
    
    public init?(error: ErrorType?) {
        if let error = error {
            self = .Failure(error)
        }
        return nil
    }
        // Conditionally returns some item B if self (set initially by optionaError / resultFromOptionalError is .Success ; workhorse of flatMap
    // H:(f:A->B), (g:C->B) -> B
    func package<B>(@noescape ifSuccess ifSuccess: A -> B, @noescape ifFailure: ErrorType -> B) -> B {
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
    
    public func flatMap<B>(@noescape transform: A -> Result<B>) -> Result<B> {
        return package(
            ifSuccess: transform,
            ifFailure: Result<B>.Failure)
    }
    
    public var error: ErrorType? {
        switch self {
        case .Failure(let error):
            return error
        default:
            return nil
        }
    }
    
    public var value: A? {
        switch self {
        case .Success(let success):
            return success
        default:
            return nil
        }
    }
}

public func resultFromOptional<A>(optional: A?, error: ErrorType) -> Result<A> {
    if let a = optional {
        return .Success(a)
    } else {
        return .Failure(error)
    }
}

public func resultFromOptionalError<A>(value: A, optionalError: ErrorType?) -> Result<A> {
    if let error = optionalError {
        return .Failure(error)
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