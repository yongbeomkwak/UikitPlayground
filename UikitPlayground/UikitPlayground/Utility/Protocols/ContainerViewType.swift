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

        addChild(viewController)
        contentView.addSubview(viewController.view)
        viewController.didMove(toParent: self)

//        viewController.view.snp.makeConstraints {
//            $0.edges.equalTo(contentView)
//        }
//        
        viewController.view.leadingAnchor.constraint(equalTo: contentView.leadingAnchor)
        viewController.view.trailingAnchor.constraint(equalTo: contentView.trailingAnchor)
        viewController.view.topAnchor.constraint(equalTo: contentView.topAnchor)
        viewController.view.bottomAnchor.constraint(equalTo: contentView.bottomAnchor)
    }

    func remove(asChildViewController viewController: UIViewController) {

        viewController.willMove(toParent: nil)
        viewController.view.removeFromSuperview()
        viewController.removeFromParent()
    }
}
