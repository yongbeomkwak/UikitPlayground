//
//  AsyncAwaitViewController.swift
//  UikitPlayground
//
//  Created by yongbeomkwak on 2023/06/15.
//

import UIKit

class AsyncAwaitViewController: UIViewController,ViewControllerFromStoryBoard {
    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!
    @IBOutlet weak var resultLabel: UITextField!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
    }
    

    public static func viewController() -> AsyncAwaitViewController { 
        
        let vc = AsyncAwaitViewController.viewController(storyBoardName: "AsyncAwaitClone", bundle: .main)
        
        
        
        
        return vc
    }

}

extension AsyncAwaitViewController {
    private func configureUI(){
        indicator.color = .blue
        indicator.startAnimating()
        
    }
}
