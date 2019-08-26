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

/// `RequestDispatcher` is the protocol you should conform to in order to
/// use Net with any networking framework you'd like
public protocol RequestDispatcher {
    
    
    /// Dispatch a standard networking request
    ///
    /// - Parameters:
    ///   - requestData: The request representation with its associated data
    ///     (HTTP method, headers, query params, body params, path, ...)
    ///   - completion: The result of the networking call
    ///     It can be a `Data` type in case of success or `Error` type in case of failure
    /// - Returns: The URLSessionTask handling the request
    func dispatch(requestData: RequestData,
                  completion: @escaping (Result<Data, Error>) -> Void) -> URLSessionTask?
    
    
    /// Dispatch a media uploading networking request
    ///
    /// - Parameters:
    ///   - requestMediaData: The media request representation with its associated data
    ///     (headers, query params, path, media data)
    ///   - completion: The result of the networking call.
    ///  It can be a `Data` type in case of success or `Error` type in case of failure
    /// - Returns: The URLSessionTask handling the request
    func dispatch(requestMediaData: RequestMediaData,
                  completion: @escaping (Result<Data, Error>) -> Void) -> URLSessionTask?
}
