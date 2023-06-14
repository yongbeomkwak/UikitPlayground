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
    
    
    var subscription = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        bindViewModel()
    }
    
    public static func viewController() -> CombineCloneViewController {
        
        let vc = CombineCloneViewController.viewController(storyBoardName: "CombineClone", bundle: .main)
        
        vc.viewModel = CombineCloneViewModel()
        
        
        
        return vc
    }
    



}

extension CombineCloneViewController {
    
    private func bindViewModel(){
        
        let input = CombineCloneViewModel.Input(
            text1: textField1.textPublisher,
            text2: textField2.textPublisher
        )
            
        
        let output = self.viewModel.transform(from: input)
        
        
        bindResultLabel(output: output)

    }
    
    
    private func bindResultLabel(output:CombineCloneViewModel.Output){
        
        output.isMatch
            .sink(receiveValue: {[weak self]  in
                
                self?.resultLabel.text = String($0)
                
            })
            .store(in: &subscription)
        
    }

    
    
}
