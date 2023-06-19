//
//  RxCloneViewController.swift
//  UikitPlayground
//
//  Created by yongbeomkwak on 2023/06/13.
//

import UIKit
import RxSwift
import RxCocoa

class RxCloneViewController: UIViewController,ViewControllerFromStoryBoard {

    @IBOutlet weak var textField1: UITextField!
    
    @IBOutlet weak var textField2: UITextField!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    private var viewModel : RxCloneViewModel!
    private lazy var input = RxCloneViewModel.Input()
    private lazy var output = viewModel.transform(from:input)
    
    let disposeBag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        bindRx()
    }
    
    public static func viewController() -> RxCloneViewController {
        
        let vc = RxCloneViewController.viewController(storyBoardName: "RxClone", bundle: .main)
        
        vc.viewModel = RxCloneViewModel()
        
        
        
        return vc
    }
    



}

extension RxCloneViewController {
    
    private func configureUI(){
        indicator.color = .blue
        indicator.startAnimating()
        
    }
    
    private func bindRx(){
        
        textField1.rx
            .text
            .orEmpty
            .debug("WWW")
            .bind(to: input.text1)
            .disposed(by: disposeBag)
        
        
        textField2.rx
            .text
            .orEmpty
            .bind(to: input.text2)
            .disposed(by: disposeBag)
        
        
        output.isMatch
            .map({String($0)})
            .bind(to: resultLabel.rx.text)
            .disposed(by: disposeBag)
        
        output.image
            .withUnretained(self)
            .subscribe(onNext: { (owner,data) in
            
                DispatchQueue.main.asyncAfter(deadline: .now() + 2) {
                    owner.indicator.stopAnimating()
                    owner.indicator.isHidden = true
                    owner.imageView.image = UIImage(data: data)
                }

        })
            .disposed(by: disposeBag)
    }
    
}
