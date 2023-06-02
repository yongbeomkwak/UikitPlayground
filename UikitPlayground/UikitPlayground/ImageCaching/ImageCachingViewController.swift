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
        
        configureUI()
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
        
        return vc
    }
    
}
 
extension ImageCachingViewController{
    private func configureUI(){
        ImageCacheManager.shared.loadImage(url: TestUrl.t1.rawValue) {[weak self] data in
            
            guard let self else {return}
            DispatchQueue.main.async {
                self.imageView.image = UIImage(data: data)
            }
            
            
        }
    }
}

enum TestUrl:String {
    case t1 = "https://is2-ssl.mzstatic.com/image/thumb/Purple113/v4/41/19/5c/41195c0e-da2f-de45-6924-325e2fab279d/mzl.dgcmevrw.png/576x768bb.png"
    case t2 = "https://is5-ssl.mzstatic.com/image/thumb/Purple116/v4/cf/17/6d/cf176d08-a7c8-23c4-3d7f-9f4ad3658998/AppIcon-0-0-1x_U007emarketing-0-0-0-7-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/60x60bb.jpg"
    case t3 = "https://is1-ssl.mzstatic.com/image/thumb/Purple113/v4/df/59/d2/df59d230-8ae2-5952-d2c1-257cbb8cc428/mzl.ffvcvidd.png/392x696bb.png"
    case t4 = "https://is4-ssl.mzstatic.com/image/thumb/Purple113/v4/7f/39/5a/7f395a0f-81cc-ed23-4f17-c705214c9171/mzl.iwsiuhbr.png/392x696bb.png"
    case t5 = "https://is5-ssl.mzstatic.com/image/thumb/Purple123/v4/64/be/aa/64beaad6-a327-ab3e-7f65-b628ae41abca/mzl.ucpwajol.png/576x768bb.png"
    case y6 = " https://is5-ssl.mzstatic.com/image/thumb/Purple116/v4/cf/17/6d/cf176d08-a7c8-23c4-3d7f-9f4ad3658998/AppIcon-0-0-1x_U007emarketing-0-0-0-7-0-0-sRGB-0-0-0-GLES2_U002c0-512MB-85-220-0-0.png/512x512bb.jpg"
    
}

