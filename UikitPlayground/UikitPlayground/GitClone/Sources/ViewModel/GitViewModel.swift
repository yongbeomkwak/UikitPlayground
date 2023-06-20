//
//  GitViewModel.swift
//  UikitPlayground
//
//  Created by yongbeomkwak on 2023/06/20.
//

import Foundation
import RxSwift
import RxRelay
import Alamofire

class GitViewModel:ViewModelType {
    
    
    let disposeBag = DisposeBag()
    
    
    struct Input {
        let text:PublishSubject<String> = .init()
    }
    
    struct Output{
        
        let dataSource:BehaviorRelay<[RepoModel]> = BehaviorRelay(value: [])
        let filteredDataSource:BehaviorRelay<[RepoModel]> = BehaviorRelay(value: [])
    }
    
    
    func transform(from input: Input) -> Output {
        
        let output = Output()
        
        input.text
            .withLatestFrom(output.dataSource){($0,$1)}
            .map { (text, dataSource) in
                return text.isEmpty ? dataSource : dataSource.filter({ $0.name.contains(text)})
            }
            .bind(to: output.filteredDataSource)
            .disposed(by: disposeBag)
        
        
        getRepos()
            .asObservable()
            .bind(to: output.dataSource,output.filteredDataSource)
            .disposed(by: disposeBag)
        
        
        
        
        
        
        return output
    }
    
    
}

extension GitViewModel {
    
    func getRepos() -> Single<[RepoModel]>{
        
       return Single.create{ single in
            
            AF.request("https://api.github.com/users/yongbeomkwak/starred",
                       method: .get,
                       headers: ["Content-Type":"application/json",
                                 "Accept":"application/json",
                                 "Authorization":"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"])
            .validate(statusCode: 200..<300)
            .responseDecodable(of:[RepoModel].self){ data in
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
