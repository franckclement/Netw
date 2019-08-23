//
//  GithubSearchResult.swift
//  NetExample
//
//  Created by Franck Clement on 19/08/2019.
//  Copyright © 2019 Franck Clement. All rights reserved.
//

import Foundation

struct GithubSearchResults<T: Decodable>: Decodable {
    let total_count: Int
    let items: [T]
}
