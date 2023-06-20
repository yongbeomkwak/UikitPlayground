//
//  GitViewModel.swift
//  UikitPlayground
//
//  Created by yongbeomkwak on 2023/06/20.
//

import Foundation
import RxSwift
import Alamofire

class GitViewModel:ViewModelType {
    
    
    let disposeBag = DisposeBag()
    
    
    struct Input {
        let text:PublishSubject<String> = .init()
    }
    
    struct Output{
        
        let dataSource:PublishSubject<[RepoModel]> = .init()
        let filteredDataSource:PublishSubject<[RepoModel]> = .init()
    }
    
    
    func transform(from input: Input) -> Output {
        
        let output = Output()
        
        input.text
            .subscribe(onNext: {
                DEBUG_LOG($0)
            })
            .disposed(by: disposeBag)
        
        
        getRepos()
            .asObservable()
            .debug("HH")
            .bind(to: output.dataSource)
            .disposed(by: disposeBag)
        
        
        return output
    }
    
    
}

extension GitViewModel {
    
    func getRepos() -> Single<[RepoModel]>{
        
        
        DEBUG_LOG("HEELL")
        
       return Single.create{ single in
            
            AF.request("https://api.github.com/users/yongbeomkwak/starred",
                       method: .get,
                       headers: ["Content-Type":"application/json",
                                 "Accept":"application/json",
                                 "Authorization":"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"])
            .validate(statusCode: 200..<300)
            .responseDecodable(of:[RepoModel].self){ data in
                DEBUG_LOG("HELLO")
                switch data.result {
                    
                case .success(let response):
                    single(.success(response))
                case .failure(let error):
                    single(.failure(error))
                }
                
            }
            
            return Disposables.create()
        }
        
    }
}
