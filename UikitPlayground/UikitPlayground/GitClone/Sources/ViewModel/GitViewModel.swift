//
//  GitViewModel.swift
//  UikitPlayground
//
//  Created by yongbeomkwak on 2023/06/20.
//

import Foundation
import RxSwift

class GitViewModel:ViewModelType {
    
    let dataSource:[RepoModel]!
    
    init(dataSource:[RepoModel]){
        self.dataSource = dataSource
    }
    
    struct Input {
        let text:PublishSubject<String> = .init()
    }
    
    struct Output{
        
        
        let filteredDataSource:PublishSubject<[RepoModel]> = .init()
    }
    
    
    func transform(from input: Input) -> Output {
        
        let output = Output()
        
        
        
        return output
    }
    
    
}
