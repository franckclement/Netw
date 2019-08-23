//
//  GithubRepositoryRequestMalformedURL.swift
//  NetTests
//
//  Created by Franck Clement on 21/08/2019.
//  Copyright © 2019 Franck Clement. All rights reserved.
//

import Foundation
import Net

struct GithubRepositorySearchRequestInvalidURL: Request {
    typealias Response = GithubSearchResults<GithubRepository>
    
    let queryRequest: String
    
    var data: DataType {
        let data = RequestData(path: "",
                               method: .get,
                               queryParams: ["q": queryRequest])
        
        return DataType.standard(data: data)
    }
    
    init(queryRequest: String) {
        self.queryRequest = queryRequest
    }
}
