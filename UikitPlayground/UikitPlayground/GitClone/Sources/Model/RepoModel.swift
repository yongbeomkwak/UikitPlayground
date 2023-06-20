//
//  RepoModel.swift
//  UikitPlayground
//
//  Created by yongbeomkwak on 2023/06/20.
//

import Foundation

struct RepoModel : Codable{
    let id,starCount: Int
    let name, fullName: String
    
    
    
    enum CodingKeys: String,CodingKey {
        case id,name
        case starCount = "stargazers_count"
        case fullName = "full_name"
    }
}
