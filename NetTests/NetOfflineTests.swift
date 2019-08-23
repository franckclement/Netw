//
//  NetOfflineTests.swift
//  NetTests
//
//  Created by Franck Clement on 21/08/2019.
//  Copyright © 2019 Franck Clement. All rights reserved.
//

import XCTest
@testable import Net

class NetOfflineTests: XCTestCase {

    override func setUp() {
        // now set up a configuration to use our mock
        let config = URLSessionConfiguration.default
        config.protocolClasses = [URLProtocolMock.self]
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    private func getMockedDataFromBundle(forResource: String, withExtension: String) -> Data {
        guard let reosurceURL = Bundle(for: URLProtocolMock.self).url(forResource: forResource, withExtension: withExtension),
            let data = try? Data(contentsOf: reosurceURL)
            else { return "error".data(using: .utf8)! }
        return data
    }

    func testSearchMockedRepositoryRequest() {
        
        URLProtocolMock.testURLs = [URL(string: "https://api.github.com/search/repositories?q=RxSwift")!: getMockedDataFromBundle(forResource: "rxswiftRepostitoryRequestResult", withExtension: "json")]
        
        // Create an expectation for a background download task.
        let expectation = XCTestExpectation(description: "Request RxSwift query on Github's repositories API")
        
        // Make the request
        let repositoryRequest = GithubRepositorySearchRequest(queryRequest: "RxSwift")
        _ = repositoryRequest.execute(completion: { result in
            switch result {
            case .success(let response):
                XCTAssertNotNil(response)
                expectation.fulfill()
                break
            case .failure(let error):
                XCTAssertNotNil(error)
                XCTFail()
                break
            }
        })
        
        wait(for: [expectation], timeout: 5.0)
    }
    
    
    func testImageUpload() {
        
        URLProtocolMock.testURLs = [URL(string: "https://api.imgur.com/3/upload")!: getMockedDataFromBundle(forResource: "imgurImageUploadResponse", withExtension: "json")]
        
        // Create an expectation for a background download task.
        let expectation = XCTestExpectation(description: "Post image to imgur upload API")
        
        let imgurMediaPostRequest = ImgurMediaPostRequest()
        _ = imgurMediaPostRequest.execute(completion: { result in
            switch result {
            case .success(let response):
                XCTAssertNotNil(response)
                expectation.fulfill()
                break
            case .failure(let error):
                XCTAssertNotNil(error)
                XCTFail()
                break
            }
        })
        
        wait(for: [expectation], timeout: 3.0)
    }

}
