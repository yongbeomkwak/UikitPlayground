//
//  ImageCachingViewController.swift
//  UikitPlayground
//
//  Created by yongbeomkwak on 2023/05/30.
//

import Foundation
import UIKit

class ImageCachingViewController : UIViewController,ViewControllerFromStoryBoard {
    
    @IBOutlet weak var imageView: UIImageView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        DEBUG_LOG("SecondVC DidLoad")
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DEBUG_LOG("SecondVC WillAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        DEBUG_LOG("SecondVC WillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        DEBUG_LOG("SecondVC DidDisappear")
    }
    
    public static func viewController() -> ImageCachingViewController {
        
        let vc = ImageCachingViewController.viewController(storyBoardName: "Main", bundle: .main)
        
        DEBUG_LOG("Hello")
        return vc
    }
    
}
 
extension ImageCachingViewController{
    
    private func configureUI(){
        
    }
}
