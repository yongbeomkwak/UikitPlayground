//
//  RxCloneViewModel.swift
//  UikitPlayground
//
//  Created by yongbeomkwak on 2023/06/13.
//

import Foundation
import Combine


class CombineCloneViewModel:ViewModelType{


    
    var subscription = Set<AnyCancellable>()
    
    public struct Input{

        
    }
    
    public struct Output{

        
    }
    
    public func transform(from input: Input) -> Output {
        
        let ouput = Output()
        
       
        
        
        return ouput
        
    }
    
    
}
