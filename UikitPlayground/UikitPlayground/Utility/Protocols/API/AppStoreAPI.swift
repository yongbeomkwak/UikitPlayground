//
//  NetworkAPI.swift
//  UikitPlayground
//
//  Created by yongbeomkwak on 2023/06/09.
//

import Foundation


public enum Domain: String {
    case search = "search/"
    case lookup = "lookup/"
}


public protocol AppStoreAPI{
    var domain: Domain { get }
    
    var urlComponent: URLComponents {get}
    
}


extension AppStoreAPI{
    
    var baseUrl:String {
        "https://itunes.apple.com/"
    }
    
    var path: String {
        baseUrl + domain.rawValue
    }
    
    var url: URL {
        urlComponent.url!
    }
}
