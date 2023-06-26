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
        let text1:AnyPublisher<String?,Never>
        let text2:AnyPublisher<String?,Never>
        
    }
    
    public struct Output{
        var isMatch:PassthroughSubject<Bool,Never> = .init()
        var dataSource:PassthroughSubject<Data,Never> = .init()
        
    }
    
    public func transform(from input: Input) -> Output {
        let output = Output()
       
        
        
        bindMatch(input: input, output: output)
        fetchImage(input: input, output: output)
        
        
       
        
        
        return output
        
    }
    
    
    
    
}

extension CombineCloneViewModel{
    
    func bindMatch(input: Input, output: Output){

        Publishers.CombineLatest(input.text1, input.text2)
            .compactMap({ ($0 ?? "" , $1 ?? "")})
            .filter({!$0.0.isEmpty || !$0.1.isEmpty})
            .map({$0.0 == $0.1})
            .sink(receiveValue: {output.isMatch.send($0)})
            .store(in: &subscription)
    }
    
    func fetchImage(input:Input,output: Output){
        
        URLSession.shared.dataTaskPublisher(for:URL(string: TestUrl.t2.rawValue)!)
            .tryMap { (data: Data, response: URLResponse) -> Data in
                guard let res = response as? HTTPURLResponse, res.statusCode == 200 else {
                    throw URLError(.badServerResponse)
                }
                return data
            }
            .sink { completion in
                
                switch completion {
                    
                case .finished:
                    DEBUG_LOG("FIN")
                case .failure(_):
                    DEBUG_LOG("Failure")
                }
                
            } receiveValue: { data in
                DEBUG_LOG("OUT")
                output.dataSource.send(data)
            }
            .store(in: &subscription)

        
    }
    
}
