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
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    
    
    private var viewModel : CombineCloneViewModel!
    
    
    var subscription = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
        bindViewModel()
    }
    
    public static func viewController() -> CombineCloneViewController {
        
        let vc = CombineCloneViewController.viewController(storyBoardName: "CombineClone", bundle: .main)
        
        vc.viewModel = CombineCloneViewModel()
        
        
        
        return vc
    }
    



}

extension CombineCloneViewController {
    
    private func configureUI(){
        indicator.color = .blue
        indicator.startAnimating()
        
    }
    
    private func bindViewModel(){
        
        let input = CombineCloneViewModel.Input(
            text1: textField1.textPublisher,
            text2: textField2.textPublisher
        )
            
        
        let output = self.viewModel.transform(from: input)
        
        
        bindResultLabel(output: output)
        fetchImage(output: output)

    }
    
    
    private func bindResultLabel(output:CombineCloneViewModel.Output){
        
        output.isMatch
            .sink(receiveValue: {[weak self]  in
                
                guard let self else {return}
                
                self.resultLabel.text = String($0)
                
            })
            .store(in: &subscription)
        
    }
    
    private func fetchImage(output:CombineCloneViewModel.Output){
        
        output.dataSource
            .sink(receiveValue:{[weak self] data in
                
                guard let self else {return}
                
                DispatchQueue.main.asyncAfter(deadline: .now() + 3){
                    
                    self.indicator.stopAnimating()
                    self.indicator.isHidden = true
                    
                    self.imageView.image = UIImage(data: data)
                }
            
            })
            .store(in: &subscription)
        
    }

    
    
}
