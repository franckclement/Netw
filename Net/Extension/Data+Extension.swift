//
//  Data+Extension.swift
//  Net
//
//  Created by Franck Clement on 22/08/2019.
//  Copyright © 2019 Franck Clement. All rights reserved.
//

import Foundation

extension Data {
    /// Convenience method to append sting to Data object
    mutating func append(_ string: String) {
        if let data = string.data(using: .utf8) {
            append(data)
        }
    }
}
