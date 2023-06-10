//
//  LookupViewModel.swift
//  UikitPlayground
//
//  Created by yongbeomkwak on 2023/06/10.
//

import Foundation

class LookupViewModel:ViewModelType{
    
    var dataSource:LookUpModel!
    
    
    public struct Input{
        
    }
    
    public struct Output{
        
    }
    
    init(dataSource:LookUpModel){
        self.dataSource = dataSource
        
    }
    
    public func transform(from input: Input) -> Output {
        
        return Output()
    }
    
}
