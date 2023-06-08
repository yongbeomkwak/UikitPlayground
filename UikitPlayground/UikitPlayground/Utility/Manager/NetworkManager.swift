//
//  NetworkManager.swift
//  UikitPlayground
//
//  Created by yongbeomkwak on 2023/06/08.
//

import Foundation

class NetworkManager {
    
    static let shared = NetworkManager()
    
    
    func loadSearchResult(url:String,completion: @escaping (SearchResultModel) -> Void)
    {
        guard let url = URL(string: url) else {return }
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            
         //  guard let self else {return}
            
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
