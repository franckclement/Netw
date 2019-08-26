/**
 *  Net
 *
 *  Copyright (c) 2019 Franck Clement. Licensed under the MIT license, as follows:
 *
 *  Permission is hereby granted, free of charge, to any person obtaining a copy
 *  of this software and associated documentation files (the "Software"), to deal
 *  in the Software without restriction, including without limitation the rights
 *  to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 *  copies of the Software, and to permit persons to whom the Software is
 *  furnished to do so, subject to the following conditions:
 *
 *  The above copyright notice and this permission notice shall be included in all
 *  copies or substantial portions of the Software.
 *
 *  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 *  IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 *  FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 *  AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 *  LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 *  OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
 *  SOFTWARE.
 */

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
