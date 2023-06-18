//
//  AsyncAwaitViewModel.swift
//  UikitPlayground
//
//  Created by yongbeomkwak on 2023/06/16.
//

import Foundation
import RxSwift

class RxAsyncAwaitViewModel:ViewModelType{
    
    
    let disposeBag = DisposeBag()
    
    public struct Input{
     
        
    }
    
    public struct Output{
     
        let dataSource:PublishSubject<Data> = .init()
        
        
    }
    

    
    func transform(from input: Input) -> Output {
        
        let output = Output()
        
        let tmpUrl = URL(string: TestUrl.t1.rawValue)!
        
        
        
        
        Task{
            if let data = await loadImage(url: tmpUrl)
            {
                
                Observable.just(data)
                    .bind(to: output.dataSource)
                    .disposed(by: disposeBag)
            }
        }
        
        
        
        
        return output
    }
    
    func loadImage(url:URL) async ->  Data? {
        
        return try? await URLSession.shared.data(from: url).0
        
    }
    
    
}

