//
//  LookupViewModel.swift
//  UikitPlayground
//
//  Created by yongbeomkwak on 2023/06/10.
//

import Foundation

public enum RatingCase {
    case starRating
    case age
    case chart
    case dev
    case lan
}

class LookupViewModel:ViewModelType{
    
    var dataSource:LookUpModel?
    var id:Int!
    let ratingCase: [RatingCase] = [.starRating,.age,.chart,.dev,.lan]
    
    public struct Input{
        
    }
    
    public struct Output{
        
    }
    
    init(id:Int){
        self.id = id
        self.dataSource = nil
    }
    
    
    public func transform(from input: Input) -> Output {
        
        return Output()
    }
    
    public func fetchData(completion:@escaping (LookUpModel) -> Void){
        
        NetworkManager.shared.loadLookupResult(id: self.id) { [weak self] dataSource in
            
            self?.dataSource = dataSource
            
            completion(dataSource)
            
        }
        
    }
    
}
