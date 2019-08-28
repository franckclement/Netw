/**
 *  Netw
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

/// Wrapper around the kind of data Netw can handles.
public enum DataType {
    /// Use `standard` for any kind of standard HTTP requests
    case standard(data: RequestData)
    /// Use `media` for media POST upload with formdata
    case media(data: RequestMediaData)
}

/// Representation of a network request
/// Conform to this protocol and provide a `data` object to get up and running
public protocol Request {
    associatedtype Response: Decodable
    var data: DataType { get }
}

public extension Request {
    
    /// This function executes the request based on `data` you provided to the Request type,
    /// through the given dispatcher, it does the networking request.
    /// And complete with a Result type containing either the `Response` or an `Error`.
    /// - Parameters:
    ///   - dispatcher: the given dispatcher to dispatch the request on. If not provided, the default `URLSessionRequestDispatcher` is used
    ///   - completion: the completion block exposing the `Result`of the request
    /// - Returns: The task responsible for the request
    func execute(with dispatcher: RequestDispatcher = URLSessionRequestDispatcher.instance,
                 completion: @escaping (Result<Response, Error>) -> Void) -> URLSessionTask? {
        
        switch self.data {
        case .media(let data):
            
            return dispatcher.dispatch(requestMediaData: data, completion: { result in
                
                switch result {
                case .success(let responseData):
                    
                    Logger.logInfo("%@", String(data: responseData, encoding: .utf8) ?? "String decoding error")
                    
                    do {
                        let jsonDecoder = JSONDecoder()
                        let result = try jsonDecoder.decode(Response.self, from: responseData)
                        
                        DispatchQueue.main.async {
                            completion(.success(result))
                        }
                    } catch {
                        DispatchQueue.main.async {
                            completion(.failure(error))
                        }
                    }
                    break
                case .failure(let error):
                    
                    switch error {
                    case NetwError.other(let reason):
                        Logger.logError("%@", reason)
                        break
                    default: Logger.logError("%@", error.localizedDescription)
                    }
                    
                    DispatchQueue.main.async {    
                        completion(.failure(error))
                    }
                    break
                }
            })
        case .standard(let data):
            
            return dispatcher.dispatch(requestData: data, completion: { result in
                
                switch result {
                case .success(let responseData):
                    
                    Logger.logInfo("%@", String(data: responseData, encoding: .utf8) ?? "String decoding error")
                    
                    do {
                        let jsonDecoder = JSONDecoder()
                        let result = try jsonDecoder.decode(Response.self, from: responseData)
                        
                        DispatchQueue.main.async {
                            completion(.success(result))
                        }
                    } catch {
                        DispatchQueue.main.async {
                            completion(.failure(error))
                        }
                    }
                    break
                case .failure(let error):
                    
                    Logger.logError("%@", error.localizedDescription)
                    
                    DispatchQueue.main.async {
                        
                        completion(.failure(error))
                    }
                    break
                }
            })
        }
    }
}
