//
//  ImgurMediaPostRequest.swift
//  NetTests
//
//  Created by Franck Clement on 21/08/2019.
//  Copyright © 2019 Franck Clement. All rights reserved.
//

import Foundation
import Net

struct ImgurMediaPostRequest: Request {
    typealias Response = ImgurImageUploadResponse
    
    var data: DataType {
        
        let mockedSessionConfiguration = URLSessionConfiguration.ephemeral
        mockedSessionConfiguration.protocolClasses = [URLProtocolMock.self]
        
        let bundle = Bundle.init(for: NetOnlineTests.self)
        let image = UIImage(named: "mockImage", in: bundle, compatibleWith: nil)!
        let media = Media(key: "image",
                          fileName: "mockImage",
                          data: image.jpegData(compressionQuality: 0.5)!,
                          mimeType: "image/png")
        
        let data = RequestMediaData(path: "https://api.imgur.com/3/upload",
                                    medias: [media],
                                    sessionConfiguration: mockedSessionConfiguration)
        
        return DataType.media(data: data)
    }
}
