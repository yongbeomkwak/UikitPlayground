//
//  AsyncAwaitViewController.swift
//  UikitPlayground
//
//  Created by yongbeomkwak on 2023/06/15.
//

import UIKit
import RxSwift
import Combine

class AsyncAwaitViewController: UIViewController,ViewControllerFromStoryBoard {
    @IBOutlet weak var textField1: UITextField!
    @IBOutlet weak var textField2: UITextField!
    @IBOutlet weak var resultLabel: UITextField!
    
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var indicator: UIActivityIndicatorView!
    
    
    private var rxViewModel : RxAsyncAwaitViewModel!
    private lazy var input = RxAsyncAwaitViewModel.Input()
    private lazy var output = rxViewModel.transform(from:input)
    
    private var combineViewModel : CombineAsyncAwaitViewModel!
    
    let disposeBag = DisposeBag()
    var subscription = Set<AnyCancellable>()
    
    override func viewDidLoad() {
        super.viewDidLoad()

        configureUI()
       // bindRx()
        bindViewModel()
    }
    

    public static func viewController() -> AsyncAwaitViewController { 
        
        let vc = AsyncAwaitViewController.viewController(storyBoardName: "AsyncAwaitClone", bundle: .main)
        
        vc.rxViewModel = RxAsyncAwaitViewModel()
        
        vc.combineViewModel = CombineAsyncAwaitViewModel()
        
        
        return vc
    }

}

extension AsyncAwaitViewController {
    private func configureUI(){
        indicator.color = .blue
        indicator.startAnimating()
    }
    
    private func bindRx(){
        
        output
            .dataSource
            .subscribe(onNext: { [weak self] data in
              
                guard let self else {return}
                
                DEBUG_LOG(Thread.current) // # number = 3
                
                Task{
                    await MainActor.run{ // == DispatchQueue.main.async
                        DEBUG_LOG(Thread.current) // # number 1 , main
                        self.indicator.stopAnimating()
                        self.indicator.isHidden = true
                        self.imageView.image = UIImage(data: data)
                    }
                }
                
            })
            .disposed(by: disposeBag)
        
    }
    
    private func bindViewModel(){
        
        let input = CombineAsyncAwaitViewModel.Input(
            text1: textField1.textPublisher,
            text2: textField2.textPublisher
        )
            
        
        let output = self.combineViewModel.transform(from: input)
        
        fetchImage(output: output)

    }
    
    private func fetchImage(output:CombineAsyncAwaitViewModel.Output){
        
        output.dataSource
            .sink(receiveValue:{[weak self] data in
                
                guard let self else {return}
                
                Task{
                    await MainActor.run{
                        self.indicator.stopAnimating()
                        self.indicator.isHidden = true
                        
                        self.imageView.image = UIImage(data: data)
                    }
                }
            
            })
            .store(in: &subscription)
        
    }
    
    
    
}
