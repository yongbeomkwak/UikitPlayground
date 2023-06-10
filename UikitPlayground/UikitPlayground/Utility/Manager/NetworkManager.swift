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
        
    private func parseData(requestURL:URL,completion:@escaping (Data) -> Void){
        
        let task = URLSession.shared.dataTask(with: requestURL) { data, response, error in

            guard  let data = data ,error == nil else {
                DEBUG_LOG("ERROR Occured")
                return
            }

         
            // 컴플리션 호출
            completion(data)
        }


        DispatchQueue.global(qos: .background).async {
            task.resume()
        }
    }
    

    
    func loadSearchResult(term:String,completion:@escaping (SearchResultModel) -> Void)
    {
        
        parseData(requestURL: SearchAPI.fetchSearch(text: term).url) { data in
            let decoder = JSONDecoder()
            guard let result = try? decoder.decode(SearchResultModel.self, from: data) else {return}
            
            completion(result)
        }
        
    }
    
    func loadLookupResult(id:Int,completion:@escaping (LookUpModel) -> Void)
    {
        
        parseData(requestURL: SearchAPI.fetchLookupDetail(id:id).url) { data in
            let decoder = JSONDecoder()
            
           guard let result = try? decoder.decode(LookUpModel.self, from: data) else {return}
            
            completion(result)
        }
    }
    
    
    
}
