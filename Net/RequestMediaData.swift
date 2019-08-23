//
//  RequestMediaData.swift
//  Net
//
//  Created by Franck Clement on 17/08/2019.
//  Copyright © 2019 Franck Clement. All rights reserved.
//

import Foundation

/// Representation of a request content aiming to upload
/// medias through multipart/form-data HTTP request (POST)
public struct RequestMediaData {
    /// The resource path to query on
    public let path: String
    /// The optional query params of the request
    public let queryParams: [String: String]?
    /// The optional headers of the request
    public let headers: [String: String]?
    /// The list of medias to upload
    public let medias: [Media]
    /// The session configuration the request will be running with
    /// The URLSessionConfiguration.default is provided if not set
    public let sessionConfiguration: URLSessionConfiguration
    
    internal let method: HTTPMethod = .post
    
    public init (
        path: String,
        queryParams: [String: String]? = nil,
        headers: [String: String]? = nil,
        medias: [Media],
        sessionConfiguration: URLSessionConfiguration = URLSessionConfiguration.default) {
        
        self.path = path
        self.queryParams = queryParams
        self.headers = headers
        self.medias = medias
        self.sessionConfiguration = sessionConfiguration
    }
}
