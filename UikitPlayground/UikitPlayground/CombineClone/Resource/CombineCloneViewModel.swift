//
//  RxCloneViewModel.swift
//  UikitPlayground
//
//  Created by yongbeomkwak on 2023/06/13.
//

import Foundation
import RxSwift


class CombineCloneViewModel:ViewModelType{

    
    let disposeBag = DisposeBag()
    
    public struct Input{
        var text1:PublishSubject<String> = PublishSubject()
        var text2:PublishSubject<String> = PublishSubject()
        
    }
    
    public struct Output{
        
        var isMatch:PublishSubject<Bool> = PublishSubject()
        
    }
    
    public func transform(from input: Input) -> Output {
        
        let ouput = Output()
        
        
        Observable.combineLatest(input.text1, input.text2)
            .map({$0 == $1})
            .bind(to: ouput.isMatch)
            .disposed(by: disposeBag)
       
        
        
        return ouput
        
    }
    
    
}
