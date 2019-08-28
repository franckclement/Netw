/**
 *  Netw
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
