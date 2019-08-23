//
//  RequestData.swift
//  Net
//
//  Created by Franck Clement on 17/08/2019.
//  Copyright © 2019 Franck Clement. All rights reserved.
//

import Foundation

/// Representation of a request content
public struct RequestData {
    /// The resource path to query on
    public let path: String
    /// The HTTP Method for the request
    public let method: HTTPMethod
    /// The optional query params of the request
    public let queryParams: [String: String]?
    /// The optional bodyParams of the request
    public let bodyParams: [String: Any?]?
    /// The optional headers of the request
    public let headers: [String: String]?
    /// The session configuration the request will be running with
    /// The URLSessionConfiguration.default is provided if not set
    public let sessionConfiguration: URLSessionConfiguration
    
    public init (
        path: String,
        method: HTTPMethod = .get,
        queryParams: [String: String]? = nil,
        bodyParams: [String: Any?]? = nil,
        headers: [String: String]? = nil,
        sessionConfiguration: URLSessionConfiguration = URLSessionConfiguration.default) {
        
        self.path = path
        self.method = method
        self.queryParams = queryParams
        self.bodyParams = bodyParams
        self.headers = headers
        self.sessionConfiguration = sessionConfiguration
    }
}
