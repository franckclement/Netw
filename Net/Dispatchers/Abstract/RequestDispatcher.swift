//
//  RequestDispatcher.swift
//  Net
//
//  Created by Franck Clement on 17/08/2019.
//  Copyright © 2019 Franck Clement. All rights reserved.
//

import Foundation

/// 
public protocol RequestDispatcher {
    
    func dispatch(requestData: RequestData,
                  completion: @escaping (Result<Data, Error>) -> Void) -> URLSessionTask?
    
    func dispatch(requestMediaData: RequestMediaData,
                  completion: @escaping (Result<Data, Error>) -> Void) -> URLSessionTask?
}
