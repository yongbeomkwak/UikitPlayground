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
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    public static func viewController() -> AsyncAwaitViewController {
        
        let vc = AsyncAwaitViewController.viewController(storyBoardName: "AsyncAwaitClone", bundle: .main)
        
        
        
        
        return vc
    }

}
