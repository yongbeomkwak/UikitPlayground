//
//  LookUpViewController.swift
//  UikitPlayground
//
//  Created by yongbeomkwak on 2023/06/10.
//

import UIKit

class LookUpViewController: BaseViewController,ViewControllerFromStoryBoard {

    @IBOutlet weak var scrollView: UIScrollView!
    @IBOutlet weak var thumbNailImageView: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var developerNameLabel: UILabel!
    @IBOutlet weak var installButton: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    
    var viewModel:LookupViewModel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
       
    }
    
    public static func viewController(viewModel:LookupViewModel) -> LookUpViewController {
        
        let vc = LookUpViewController.viewController(storyBoardName: "Appstore", bundle: .main)
        
        vc.viewModel = viewModel
        
        return vc
    }
    

}


extension LookUpViewController {
    func configureUI(){
        
        self.thumbNailImageView.layer.cornerRadius = 12
        self.thumbNailImageView.clipsToBounds = true
        
        guard let model = viewModel.dataSource.results.first else {
            return
        }
        
        ImageCacheManager.shared.loadImage(url: model.artworkUrl512) { data in
            
            DispatchQueue.main.async { [weak self] in
                guard let self else {return}
                self.thumbNailImageView.image = UIImage(data: data)
            }
        }
        
        
    }
}
