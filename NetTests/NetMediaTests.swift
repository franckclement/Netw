//
//  NetTests.swift
//  NetTests
//
//  Created by Franck Clement on 16/08/2019.
//  Copyright © 2019 Franck Clement. All rights reserved.
//

import XCTest
@testable import Net

class NetMediaTests: XCTestCase {

    func testMediaCreation() {
        
        let key: String = "key"
        let fileName: String = "filename"
        let data: Data = "data".data(using: .utf8)!
        let mimeType: String = "mimeType"
        
        let media = Media(key: key,
                          fileName: fileName,
                          data: data,
                          mimeType: mimeType)
        
        XCTAssertEqual(media.key, key)
        XCTAssertEqual(media.fileName, fileName)
        XCTAssertEqual(media.data, data)
        XCTAssertEqual(media.mimeType, mimeType)
    }

}
