//
//  SearchResultModel.swift
//  UikitPlayground
//
//  Created by yongbeomkwak on 2023/06/08.
//

import Foundation

struct SearchResultModel: Codable {
    let resultCount: Int
    let results: [SearchDetail]
}

// MARK: - Result
struct SearchDetail: Codable {
    let screenshotUrls: [String]
    let artworkUrl60, artworkUrl512, artworkUrl100: String
    let trackID: Int
    let trackName: String
    let userRatingCountForCurrentVersion: Int
    let averageUserRating: Double
    let userRatingCount: Int

    enum CodingKeys: String, CodingKey {
        case screenshotUrls,artworkUrl60, artworkUrl512, artworkUrl100
        case trackID = "trackId"
        case trackName
        case userRatingCountForCurrentVersion, averageUserRating
        case userRatingCount
    }
}
