//
//  URLProtocolMock.swift
//  NetTests
//
//  Created by Franck Clement on 21/08/2019.
//  Copyright © 2019 Franck Clement. All rights reserved.
//

import Foundation

/// This class is used to mock network calls during unit testing.
/// Simply provide any URL you want to mock and its corresponding value
/// to the static testUrls Dictionary
class URLProtocolMock: URLProtocol {
    
    static var testURLs = [URL?: Data]()
    
    override class func canInit(with request: URLRequest) -> Bool {
        return true
    }
    
    override class func canonicalRequest(for request: URLRequest) -> URLRequest {
        return request
    }
    
    override func startLoading() {
        if let url = request.url {
            // if the url is contained in ou testURLs dictionnary
            if let data = URLProtocolMock.testURLs[url] {
                // then returns immediateli the corresponding data
                self.client?.urlProtocol(self, didLoad: data)
            }
        }
        self.client?.urlProtocolDidFinishLoading(self)
    }
    
    override func stopLoading() { }
}
