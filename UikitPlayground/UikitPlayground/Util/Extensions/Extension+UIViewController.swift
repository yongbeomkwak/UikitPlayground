//
//  Extension+UIViewController.swift
//  UikitPlayground
//
//  Created by yongbeomkwak on 2023/05/20.
//

import Foundation
import UIKit

extension UIViewController{
    /// 뷰 컨트롤러로부터 네비게이션 컨트롤러를 입혀 반환합니다.
        /// 화면 이동을 위해서 필요합니다.
        /// https://etst.tistory.com/84
        /// - Returns: UINavigationController
        var wrapNavigationController: UINavigationController {
            return UINavigationController(rootViewController: self)
        }
    
    
        static func rootViewController() -> UIViewController? {


                var root: UIViewController?
            
            if #available(iOS 15.0, *){ //iOS 15 이상
                
                
                if let rootViewController = UIApplication.shared.connectedScenes
                    .filter({$0.activationState == . foregroundActive})
                    .map({$0 as? UIWindowScene})
                    .compactMap({$0}).first?.windows.first?.rootViewController {
                    if rootViewController is UINavigationController {
                        root = (rootViewController as! UINavigationController).visibleViewController!

                    }else{
                        if let presentedViewController = rootViewController.presentedViewController {
                            root  = presentedViewController
                        }
                    }
                }
                
                    
                    
                
            }
            else {
                if let rootViewController = UIApplication.shared.windows.first?.rootViewController {

                    if rootViewController is UINavigationController {
                        root = (rootViewController as! UINavigationController).visibleViewController!

                    }else{
                        if let presentedViewController = rootViewController.presentedViewController {
                            root  = presentedViewController
                        }
                    }
                }
                
            }
               
            return root
        }
    
}
