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

import XCTest
@testable import Net

class NetOnlineTests: XCTestCase {

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
