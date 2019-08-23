//
//  ImgurMediaPostRequestInvalidURL.swift
//  NetTests
//
//  Created by Franck Clement on 22/08/2019.
//  Copyright © 2019 Franck Clement. All rights reserved.
//

import Foundation
import Net

struct ImgurMediaPostRequestInvalidURL: Request {
    typealias Response = ImgurImageUploadResponse
    
    var data: DataType {
        
        let bundle = Bundle.init(for: NetOnlineTests.self)
        let image = UIImage(named: "mockImage", in: bundle, compatibleWith: nil)!
        let media = Media(key: "image",
                          fileName: "mockImage",
                          data: image.jpegData(compressionQuality: 0.5)!,
                          mimeType: "image/png")
        
        let data = RequestMediaData(path: "",
                                    medias: [media])
        
        return DataType.media(data: data)
    }
}
