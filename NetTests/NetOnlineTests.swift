//
//  NetOnlineTests.swift
//  NetTests
//
//  Created by Franck Clement on 19/08/2019.
//  Copyright © 2019 Franck Clement. All rights reserved.
//

import XCTest
@testable import Net

class NetOnlineTests: XCTestCase {

    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testSearchRepositoryRequest() {
        
        // Create an expectation for a background download task.
        let expectation = XCTestExpectation(description: "Request RxSwift query on Github's repositories API")
        
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
        
         wait(for: [expectation], timeout: 3.0)
    }
    
    func testSearchRepositoryRequestCanceled() {
        
        // Create an expectation for a background download task.
        let expectation = XCTestExpectation(description: "Request RxCocoa query on Github's repositories API")
        
        let repositoryRequest = GithubRepositorySearchRequest(queryRequest: "RxCocoa")
        let dataTask = repositoryRequest.execute(completion: { result in
            switch result {
            case .success(let response):
                XCTAssertNotNil(response)
                XCTFail()
                break
            case .failure(let error):
                XCTAssertNotNil(error)
                expectation.fulfill()
                break
            }
        })
        
        dataTask?.cancel()
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testSearchMockedRepositoryRequestInvalidURL() {
        
        // Create an expectation for a background download task.
        let expectation = XCTestExpectation(description: "Request RxCocoa query on Github's repositories API, given an empty URL")
        
        let repositoryRequest = GithubRepositorySearchRequestInvalidURL(queryRequest: "RxCocoa")
        _ = repositoryRequest.execute(completion: { result in
            switch result {
            case .success:
                XCTFail()
                break
            case .failure(let error):
                switch error {
                case NetError.invalidURL:
                    expectation.fulfill()
                default:
                    XCTFail("This error should be NetError.invalidURL")
                }
                break
            }
        })
        
        wait(for: [expectation], timeout: 1.0)
    }
    
    func testImgurMediaPostRequestInvalidURL() {
        
        // Create an expectation for a background download task.
        let expectation = XCTestExpectation(description: "Image upload to imgur API given an empty URL")
        
        let imgurInvalidURLRequest = ImgurMediaPostRequestInvalidURL()
        _ = imgurInvalidURLRequest.execute(completion: { result in
            switch result {
            case .success:
                XCTFail()
                break
            case .failure(let error):
                switch error {
                case NetError.invalidURL:
                    expectation.fulfill()
                default:
                    XCTFail("This error should be NetError.invalidURL")
                }

                break
            }
        })
        
        wait(for: [expectation], timeout: 1.0)
    }

}
