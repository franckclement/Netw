# Netw
Netw is a lightweight iOS wrapper around URLSession that allows you to define clean HTTP requests

![Swift Version](https://img.shields.io/badge/Swift-5.0.1-F16D39.svg?style=flat)
[![Build Status](https://travis-ci.org/franckclement/Netw.svg?branch=master)](https://travis-ci.org/franckclement/Netw)
[![codecov](https://codecov.io/gh/franckclement/Netw/branch/master/graph/badge.svg)](https://codecov.io/gh/franckclement/Netw)
[![License][license-image]][license-url]
[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/Netw)](https://cocoapods.org/pods/Netw)

Netw provides a clean way to define and make your networking calls. It supports standard HTTP methods as well as multipart/formdata media upload.

## Features

- [x] Define clean and isolated HTTP requests
- [x] Support for multipart/formdata requests 
- [x] Built on top of URLSession
- [x] No external libraries imported

## Requirements

- iOS 10.0+

## Installation

#### CocoaPods
You can use [CocoaPods](http://cocoapods.org/) to install `Netw` by adding it to your `Podfile`:

```ruby
pod 'Netw'
```

## Usage example

### 1) Create a `Request` struct with your request settings

#### For a standard HTTP request

```swift
import Netw

struct GithubRepositorySearchRequest: Request {
    // Response type must conforms to Decodable
    typealias Response = GithubSearchResults<GithubRepository>
    
    // Setup your requests parameters as properties
    let queryRequest: String
    
    var data: DataType {
        let data = RequestData(path: "https://api.github.com/search/repositories",
                               method: .get,
                               queryParams: ["q": queryRequest])
        
        return DataType.standard(data: data)
    }
    
    // Initialize your custom request passing your custom parameters
    init(queryRequest: String) {
        self.queryRequest = queryRequest
    }
}
```

`GithubSearchResults<>` and `GithubRepository` types can be seen [here](https://github.com/franckclement/Netw/tree/master/NetwTests/GithubAPI/Model)

#### For a media HTTP multipart/formdata POST request

```swift
import Netw

struct ImgurMediaPostRequest: Request {
    typealias Response = ImgurImageUploadResponse
    
    var data: DataType {
        // We get an in-bundle image for test purpose
        let bundle = Bundle.init(for: YouBundleClass.self)
        let image = UIImage(named: "mockImage", in: bundle, compatibleWith: nil)!
        // Use the built in Media type to create your medias to ulpload
        let media = Media(key: "image",
                          fileName: "mockImage",
                          data: image.jpegData(compressionQuality: 0.5)!,
                          mimeType: "image/png")
        let data = RequestMediaData(path: "https://api.imgur.com/3/upload",
                                    medias: [media])
        return DataType.media(data: data)
    }
}
```

`ImgurImageUploadResponse` type can be seen [here](https://github.com/franckclement/Netw/tree/master/NetwTests/GithubAPI/Model)

### 2) Use your custom `Request.execute(completion:)` method to dispatch network calls

```swift
let repositoryRequest = GithubRepositorySearchRequest(queryRequest: "RxSwift")
_ = repositoryRequest.execute(completion: { result in
    switch result {
    case .success(let response):
        print(response)
    case .failure(let error):
        print(error)
        break
    }
})
```

## Contribute

Submit a pull request 🚀

## Meta

Franck CLEMENT – [@Twitter](https://twitter.com/Francklement)

Distributed under the MIT license. See [``LICENSE``](https://github.com/franckclement/Netw/blob/master/LICENSE) for more information.

[license-image]: https://img.shields.io/badge/License-MIT-blue.svg
[license-url]: LICENSE
