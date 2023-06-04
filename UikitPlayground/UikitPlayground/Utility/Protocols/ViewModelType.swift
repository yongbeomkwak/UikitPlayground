//
//  ViewModelProtocol.swift
//  UikitPlayground
//
//  Created by yongbeomkwak on 2023/06/04.
//

import Foundation

public protocol ViewModelType {
    /*Swift - Associated Type이란 무엇인가??!

    프로토콜을 정의할 때, 몇몇을 associated type으로 선언하면 매우 유용할 때가 있다.
     associated type은 프로토콜의 일부로 사용되는 타입을 위한 placeholder 역할을 한다. associated type은 정의하는 프로토콜이 채택되기 전까지 실제 타입이 명시되지 않는다.
     */
    
    associatedtype Input
    associatedtype Output

    func transform(from input: Input) -> Output
}
