//
//  NetError.swift
//  Net
//
//  Created by Franck Clement on 17/08/2019.
//  Copyright © 2019 Franck Clement. All rights reserved.
//

import Foundation

public enum NetError: Error {
    case invalidURL
    case invalidQueryParams
    case notFound
    case noData
    case other(reason: String)
}
