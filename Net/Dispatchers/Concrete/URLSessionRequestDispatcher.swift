//
//  URLSessionRequestDispatcher.swift
//  Net
//
//  Created by Franck Clement on 17/08/2019.
//  Copyright © 2019 Franck Clement. All rights reserved.
//

import Foundation

/// Concrete implementation of `RequestDispatcher` using `URLSession.dataTask`
public struct URLSessionRequestDispatcher: RequestDispatcher {
    
    public static let instance = URLSessionRequestDispatcher()
    private init() {}
    
    // MARK: Public Methods
    
    public func dispatch(requestData: RequestData,
                         completion: @escaping (Result<Data, Error>) -> Void) -> URLSessionTask? {
        
        do {
            let urlRequest = try makeURLRequest(from: requestData)
            return makeDataTask(with: urlRequest,
                                sessionConfiguration: requestData.sessionConfiguration,
                                completion: completion)
        } catch {
            completion(.failure(error))
        }
        
        return nil
    }
    
    public func dispatch(requestMediaData: RequestMediaData,
                         completion: @escaping (Result<Data, Error>) -> Void) -> URLSessionTask? {
        
        do {
            let urlRequest = try makeURLRequest(from: requestMediaData)
            return makeDataTask(with: urlRequest,
                                sessionConfiguration: requestMediaData.sessionConfiguration,
                                completion: completion)
        } catch {
            completion(.failure(error))
        }
        
        return nil
    }
    
    // MARK: Private Methods
    
    private func makeDataTask(with urlRequest: URLRequest,
                              sessionConfiguration: URLSessionConfiguration = URLSessionConfiguration.default,
                              completion: @escaping (Result<Data, Error>) -> Void) -> URLSessionDataTask {
        
        let task = URLSession(configuration: sessionConfiguration).dataTask(with: urlRequest) { (data, response, error) in
            
            if let httpResponse = response as? HTTPURLResponse {
                switch httpResponse.statusCode {
                case 404:
                    completion(.failure(NetError.notFound))
                    return
                case 200...299: break
                default:
                    var reason: String
                    if let data = data, let r = String(data: data, encoding: .utf8) {
                        reason = r
                    } else {
                        reason = "no data to show associated with this error"
                    }
                    completion(.failure(NetError.other(reason: reason)))
                    return
                }
            }
            
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let _data = data else {
               completion(.failure(NetError.noData))
                return
            }
            completion(.success(_data))
        }
        
        task.resume()
        return task
    }
    
    private func generateBoundary() -> String {
        return "Boundary-\(UUID().uuidString)"
    }
    
    private func createDataBody(medias: [Media],
                                boundary: String) -> Data {
        
        let lineBreak = "\r\n"
        var body = Data()
        
        for photo in medias {
            body.append("--\(boundary + lineBreak)")
            body.append("Content-Disposition: form-data; name=\"\(photo.key)\"; filename=\"\(photo.fileName)\"\(lineBreak)")
            body.append("Content-Type: \(photo.mimeType + lineBreak + lineBreak)")
            body.append(photo.data)
            body.append(lineBreak)
        }
        
        body.append("--\(boundary)--\(lineBreak)")
        
        return body
    }
    
    private func makeURLRequest(from requestData: RequestData) throws ->  URLRequest {
        
        guard let url = URL(string: requestData.path) else {
            throw NetError.invalidURL
        }
        
        var urlRequest = URLRequest(url: url)
        
        if let headers = requestData.headers {
            urlRequest.allHTTPHeaderFields = headers
        }
        
        if let queryParams = requestData.queryParams {
            
            if var urlComponents = URLComponents(url: url, resolvingAgainstBaseURL: false) {
                urlComponents.queryItems = queryParams.map { URLQueryItem(name: $0.key, value: $0.value) }
                if let url = urlComponents.url {
                    urlRequest = URLRequest(url: url)
                } else {
                    throw NetError.invalidQueryParams
                }
            } else {
                urlRequest = URLRequest(url: url)
            }
            
        } else {
            urlRequest = URLRequest(url: url)
        }
        
        urlRequest.httpMethod = requestData.method.rawValue
        
        if let params = requestData.bodyParams {
            urlRequest.httpBody = try JSONSerialization.data(withJSONObject: params, options: [])
        }
        
        return urlRequest
    }
    
    private func makeURLRequest(from requestMediaData: RequestMediaData) throws -> URLRequest {
        
        let tempRequestData = RequestData(path: requestMediaData.path,
                                          method: requestMediaData.method,
                                          queryParams: requestMediaData.queryParams,
                                          bodyParams: nil,
                                          headers: requestMediaData.headers)
        
        var urlRequest: URLRequest = try makeURLRequest(from: tempRequestData)
        
        let boundary = generateBoundary()
        
        // Override `urlRequest` headers generated by `tempRequestData` to support multipart/form-data
        if let headers = requestMediaData.headers {
            var mutableHeader = headers
            mutableHeader.updateValue("multipart/form-data; boundary=\(boundary)", forKey: "Content-Type")
            urlRequest.allHTTPHeaderFields = mutableHeader
        }
        
        urlRequest.httpBody = createDataBody(medias: requestMediaData.medias,
                                             boundary: boundary)
        
        return urlRequest
    }
}

