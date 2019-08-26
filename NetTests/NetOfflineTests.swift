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

class NetOfflineTests: XCTestCase {

    override func setUp() {
        // Set up a configuration to use our mock
        let config = URLSessionConfiguration.default
        config.protocolClasses = [URLProtocolMock.self]
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
