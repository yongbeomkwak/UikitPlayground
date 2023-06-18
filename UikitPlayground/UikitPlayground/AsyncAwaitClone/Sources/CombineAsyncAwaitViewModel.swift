//
//  RxCloneViewModel.swift
//  UikitPlayground
//
//  Created by yongbeomkwak on 2023/06/13.
//

import Foundation
import Combine


class CombineAsyncAwaitViewModel:ViewModelType{


    
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
        
        Task{
            await fetchImage(input: input, output: output)
        }
        
       
        
        
        return output
        
    }
    
    
    
    
}

extension CombineAsyncAwaitViewModel{
    
    func bindMatch(input: Input, output: Output){
        
        Publishers.CombineLatest(input.text1, input.text2)
            .compactMap({ ($0 ?? "" , $1 ?? "")})
            .filter({!$0.0.isEmpty || !$0.1.isEmpty})
            .map({$0.0 == $0.1})
            .sink(receiveValue: {output.isMatch.send($0)})
            .store(in: &subscription)
    }
    
    func fetchImage(input:Input,output: Output) async  {
        
        
        Task{
            do {
                let data = try await URLSession.shared.data(from:URL(string: TestUrl.t2.rawValue)!).0
                output.dataSource.send(data)
                
                
            }
            catch {
                DEBUG_LOG(error.localizedDescription)
            }
        }

        
    }
    
}
