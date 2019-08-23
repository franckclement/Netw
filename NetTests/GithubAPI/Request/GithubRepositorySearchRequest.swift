//
//  GithubRepositorySearchQuery.swift
//  NetExample
//
//  Created by Franck Clement on 19/08/2019.
//  Copyright © 2019 Franck Clement. All rights reserved.
//

import Foundation
import Net

struct GithubRepositorySearchRequest: Request {
    typealias Response = GithubSearchResults<GithubRepository>
    
    let queryRequest: String
    
    var data: DataType {
        
        let mockedSessionConfiguration = URLSessionConfiguration.ephemeral
        mockedSessionConfiguration.protocolClasses = [URLProtocolMock.self]
        
        let data = RequestData(path: "https://api.github.com/search/repositories",
                               method: .get,
                               queryParams: ["q": queryRequest],
                               sessionConfiguration: mockedSessionConfiguration)
        
        return DataType.standard(data: data)
    }
    
    init(queryRequest: String) {
        self.queryRequest = queryRequest
    }
}
