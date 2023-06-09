//
//  LookUpModel.swift
//  UikitPlayground
//
//  Created by yongbeomkwak on 2023/06/09.
//

import Foundation

struct LookUpModel: Codable {
    let resultCount: Int
    let results: [LookUpDetail]
}

// MARK: - Result
struct LookUpDetail: Codable {
    let screenshotUrls: [String]
    let artworkUrl60, artworkUrl512, artworkUrl100: String
    let artistName: String
    let trackID: Int
    let trackName: String
    let userRatingCountForCurrentVersion: Int
    let averageUserRating: Double
    let userRatingCount: Int
    let languageCodesISO2A: [String]
    let genres: [String]
    

    enum CodingKeys: String, CodingKey {
        case screenshotUrls,artworkUrl60, artworkUrl512, artworkUrl100 , artistName
        case trackID = "trackId"
        case trackName
        case userRatingCountForCurrentVersion, averageUserRating
        case genres , languageCodesISO2A
        case userRatingCount
    }
}
