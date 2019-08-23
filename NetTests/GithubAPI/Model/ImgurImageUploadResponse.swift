//
//  ImgurImageUploadResponse.swift
//  NetTests
//
//  Created by Franck Clement on 22/08/2019.
//  Copyright © 2019 Franck Clement. All rights reserved.
//

import Foundation

struct ImgurImageUploadResponse: Decodable {
    let success: Bool
    let status: Int
}
