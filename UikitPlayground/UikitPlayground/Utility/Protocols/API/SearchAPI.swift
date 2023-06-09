//
//  SearchAPI.swift
//  UikitPlayground
//
//  Created by yongbeomkwak on 2023/06/09.
//

import Foundation

public enum SearchAPI {
    case fetchSearch(text:String)
    case fetchdetail(id:String)
}

extension SearchAPI:AppStoreAPI{
    public var domain: Domain {
        
        switch self {
        case .fetchSearch:
            return .search
        case .fetchdetail:
            return .lookup
        }
    }
    
    public var urlComponent: URLComponents {
        
        switch self {
            
        case .fetchSearch(text: let text):
            
            var component = URLComponents(string: path)
            
            var queryItemArray:[URLQueryItem] = []
            
            queryItemArray.append( URLQueryItem(name: "term", value: text ))
            queryItemArray.append(URLQueryItem(name: "country", value: "kr"))
            queryItemArray.append(URLQueryItem(name: "entity", value: "software"))
            queryItemArray.append(URLQueryItem(name: "limit", value: "10"))
            
            component?.queryItems = queryItemArray
            
            return component!
            
            
            
        case .fetchdetail(id: let id):
            var component = URLComponents(string: path)
            
            var queryItemArray:[URLQueryItem] = []
            
            queryItemArray.append( URLQueryItem(name: "id", value: id ))

            
            component?.queryItems = queryItemArray
            
            return component!
            
            
        }
    }
    
}
