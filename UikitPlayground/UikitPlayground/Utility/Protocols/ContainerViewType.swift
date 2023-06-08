//
//  ContainerViewType.swift
//  UikitPlayground
//
//  Created by yongbeomkwak on 2023/06/04.
//

import Foundation
import UIKit

public protocol ContainerViewType{
    var contentView: UIView! {get set}
}

public extension ContainerViewType where Self: UIViewController {
    
    func add(asChildViewController viewController: UIViewController) {

        addChild(viewController) // 붙힘
        contentView.addSubview(viewController.view) // 자식뷰 리스트에 등록
        viewController.didMove(toParent: self) // 옮긴다고 시그널?

//        viewController.view.snp.makeConstraints {
//            $0.edges.equalTo(contentView)
//        }
//
        //오토레이아웃 내가 직접 설정할거야 그러니깐 뷰가 자동으로 모시깽이 되는 조건은 false되라 
        viewController.view.translatesAutoresizingMaskIntoConstraints = false  // 자동 재약조건 해제
        viewController.view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor,constant: 0).isActive = true
        viewController.view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor,constant: 0).isActive = true
        viewController.view.topAnchor.constraint(equalTo: contentView.topAnchor,constant: 0).isActive = true
        viewController.view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor,constant: 0).isActive = true
    }

    func remove(asChildViewController viewController: UIViewController) {

        viewController.willMove(toParent: nil) // 땐다고 시그널 보냄
        viewController.view.removeFromSuperview() // 실질적으로 땜
        viewController.removeFromParent() // 자식뷰 배열에서 뺌
    }
}
