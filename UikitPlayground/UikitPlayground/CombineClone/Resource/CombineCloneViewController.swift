//
//  RxCloneViewController.swift
//  UikitPlayground
//
//  Created by yongbeomkwak on 2023/06/13.
//

import UIKit
import Combine
import CombineCocoa

class CombineCloneViewController: UIViewController,ViewControllerFromStoryBoard {

    @IBOutlet weak var textField1: UITextField!
    
    @IBOutlet weak var textField2: UITextField!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    private var viewModel : CombineCloneViewModel!
    private lazy var input = CombineCloneViewModel.Input()
    private lazy var output = viewModel.transform(from:input)
    
    var subscription = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bindRx()
    }
    
    public static func viewController() -> CombineCloneViewController {
        
        let vc = CombineCloneViewController.viewController(storyBoardName: "CombineClone", bundle: .main)
        
        vc.viewModel = CombineCloneViewModel()
        
        
        
        return vc
    }
    



}

extension CombineCloneViewController {
    
    private func bindRx(){
        

        
    }
    
}
