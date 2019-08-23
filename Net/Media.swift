//
//  Media.swift
//  Net
//
//  Created by Franck Clement on 17/08/2019.
//  Copyright © 2019 Franck Clement. All rights reserved.
//

import Foundation

/// Representation of a media file to upload
public struct Media {
    /// The identification name of the resource
    /// this is used as formdata `name`
    let key: String
    /// The formdata filename of the resource
    /// this is used as formdata `fileName`
    let fileName: String
    /// The resource data
    let data: Data
    /// The mimeType of the resource (e.g. image/png, image/jpeg, video/mp4, ...)
    let mimeType: String
    
    public init(key: String,
                fileName: String,
                data: Data,
                mimeType: String) {
        self.key = key
        self.fileName = fileName
        self.data = data
        self.mimeType = mimeType
    }
}
