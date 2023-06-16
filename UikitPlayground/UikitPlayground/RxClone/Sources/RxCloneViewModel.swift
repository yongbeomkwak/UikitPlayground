//
//  RxCloneViewModel.swift
//  UikitPlayground
//
//  Created by yongbeomkwak on 2023/06/13.
//

import Foundation
import RxSwift


class RxCloneViewModel:ViewModelType{

    
    let disposeBag = DisposeBag()
    
    public struct Input{
        var text1:PublishSubject<String> = PublishSubject()
        var text2:PublishSubject<String> = PublishSubject()
        
    }
    
    public struct Output{
        
        var isMatch:PublishSubject<Bool> = PublishSubject()
        var image:PublishSubject<Data> = .init()
        
    }
    
    public func transform(from input: Input) -> Output {
        
        let output = Output()
        
        
        Observable.combineLatest(input.text1, input.text2)
            .map({$0 == $1})
            .bind(to: output.isMatch)
            .disposed(by: disposeBag)
        
        
        let tmpUrl = URL(string: TestUrl.t1.rawValue)!
        
        URLSession.shared.rx.data(request: URLRequest(url: tmpUrl))
            .bind(to: output.image)
            .disposed(by: disposeBag)
        
        
       
        
        
        return output
        
    }
    
    
}
