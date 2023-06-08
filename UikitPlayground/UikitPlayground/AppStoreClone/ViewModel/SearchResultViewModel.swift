//
//  SearchResultViewModel.swift
//  UikitPlayground
//
//  Created by yongbeomkwak on 2023/06/08.
//

import Foundation

class SearchResultViewModel:ViewModelType{
    
    var dataSource:SearchResultModel!
    
    
    public struct Input{
        
    }
    
    public struct Output{
        
    }
    
    init(dataSource:SearchResultModel){
        self.dataSource = dataSource
        
        DEBUG_LOG("RESULT: \(dataSource.resultCount)")
    }
    
    public func transform(from input: Input) -> Output {
        
        return Output()
    }
    
}
