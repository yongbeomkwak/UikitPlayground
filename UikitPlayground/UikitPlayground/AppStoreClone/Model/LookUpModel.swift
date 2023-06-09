//
//  LookUpModel.swift
//  UikitPlayground
//
//  Created by yongbeomkwak on 2023/06/09.
//

import Foundation

struct LookUpModel: Codable {
    
    let results: [LookUpDetail]
}

// MARK: - Result
struct LookUpDetail: Codable {
    let screenshotUrls: [String]
    let artworkUrl60, artworkUrl512, artworkUrl100, artistName: String
    let trackID: Int
    let trackName: String
    let userRatingCountForCurrentVersion: Int
    let averageUserRating: Double
    let userRatingCount: Int
    let language: [String]
    let genres: [String]
    

    enum CodingKeys: String, CodingKey {
        case screenshotUrls,artworkUrl60, artworkUrl512, artworkUrl100 , artistName
        case trackID = "trackId"
        case trackName
        case userRatingCountForCurrentVersion, averageUserRating , genres
        case userRatingCount
        case language = "languageCodesISO2A"
    }
}
