//
//  GithubRepository.swift
//  NetExample
//
//  Created by Franck Clement on 19/08/2019.
//  Copyright © 2019 Franck Clement. All rights reserved.
//

import Foundation

struct GithubRepository {
    let id: UInt32
    let name: String
    let fullName: String
    let description: String
}

extension GithubRepository: Decodable {
    
    private enum GithubRepositoryCodingKeys: String, CodingKey {
        case id
        case name
        case fullName = "full_name"
        case description
    }
    
    init(from decoder: Decoder) throws {
        let ghRepoContainer = try decoder.container(keyedBy: GithubRepositoryCodingKeys.self)
        let id = try ghRepoContainer.decode(UInt32.self, forKey: .id)
        let name = try ghRepoContainer.decode(String.self, forKey: .name)
        let fullname = try ghRepoContainer.decode(String.self, forKey: .fullName)
        let description = try ghRepoContainer.decode(String.self, forKey: .description)
        
        self.init(id: id, name: name, fullName: fullname, description: description)
    }
}
