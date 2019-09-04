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

import UIKit
import Netw

struct ImgurMediaPostRequest: Request {
    typealias Response = ImgurImageUploadResponse
    
    let sessionConfiguration: URLSessionConfiguration?
    
    var data: DataType {
        
        let bundle = Bundle.init(for: NetwOnlineTests.self)
        let image = UIImage(named: "mockImage", in: bundle, compatibleWith: nil)!
        let media = Media(key: "image",
                          fileName: "mockImage",
                          data: image.jpegData(compressionQuality: 0.5)!,
                          mimeType: "image/png")
        
        let data = RequestMediaData(path: "https://api.imgur.com/3/upload",
                                    medias: [media],
                                    sessionConfiguration: sessionConfiguration ?? URLSessionConfiguration.default)
        
        return DataType.media(data: data)
    }
    
    init(sessionConfiguration: URLSessionConfiguration? = nil) {
        self.sessionConfiguration = sessionConfiguration
    }
}
