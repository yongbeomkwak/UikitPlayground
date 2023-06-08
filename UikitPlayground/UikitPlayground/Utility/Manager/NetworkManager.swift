//
//  NetworkManager.swift
//  UikitPlayground
//
//  Created by yongbeomkwak on 2023/06/08.
//

import Foundation


// 참고 자료: https://gyuios.tistory.com/108
class NetworkManager {
    
    static let shared = NetworkManager()
    
    private var searchApi = "https://itunes.apple.com/search"
    
    
    func loadSearchResult(term:String,completion: @escaping (SearchResultModel) -> Void)
    {
        guard var urlComponent = URLComponents(string: searchApi) else {return }
        
        var queryItemArray:[URLQueryItem] = []
        
        queryItemArray.append( URLQueryItem(name: "term", value: term ))
        queryItemArray.append(URLQueryItem(name: "country", value: "kr"))
        queryItemArray.append(URLQueryItem(name: "entity", value: "software"))
        queryItemArray.append(URLQueryItem(name: "limit", value: "10"))
        
        urlComponent.queryItems = queryItemArray
        
        
        
        // request method 는 기본적으로 GET 이다. 혹시나 POST 등을 사용하고 싶다면 URLRequest 을 만들어야한다.
        // var request = URLRequest(url: requestURL)
        // request.httpMethod = "GET"
        
        guard let requestURL = urlComponent.url else { return }
        
        
        
        
        let task = URLSession.shared.dataTask(with: requestURL) { data, response, error in
            
            guard  let data = data ,error == nil else {
                DEBUG_LOG("ERROR Occured")
                return
            }
            
            let decoder = JSONDecoder()
            guard let result = try? decoder.decode(SearchResultModel.self, from: data) else {return}
            
            DEBUG_LOG("RESULT:\(result)")
            
            completion(result)
        }
        
        
        DispatchQueue.global(qos: .background).async {
            task.resume()
        }
        
    }
    
}
