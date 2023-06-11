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
    
    @IBOutlet weak var topCollectionView: UICollectionView!
    
    var viewModel:LookupViewModel!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureUI()
        bindCompletion()
        
       
       
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
        
       
        

        
        
        self.titleLabel.font = .systemFont(ofSize: 15, weight: .bold)
       
        
        self.developerNameLabel.font = .systemFont(ofSize: 12, weight: .light)
        self.developerNameLabel.textColor = .systemGray2
       
        
        
        self.installButton.setTitle("받기", for: .normal)
        self.installButton.tintColor = .white
        self.installButton.backgroundColor = .systemBlue
        self.installButton.layer.cornerRadius = 12.5
        self.installButton.clipsToBounds = true
        
        self.shareButton.tintColor = .systemBlue
        self.shareButton.setImage(UIImage(systemName: "square.and.arrow.up"), for: .normal)
        
        
        self.topCollectionView.dataSource = self
        self.topCollectionView.delegate = self
        
    }
    
    func bindCompletion() {
        viewModel.fetchData { [weak self] result in

            guard let self else {return}
            guard let model = result.results.first else {return}
            
            DispatchQueue.main.async {
                self.titleLabel.text = model.trackName
                self.developerNameLabel.text = model.artistName
            }
            
            
            
            
            ImageCacheManager.shared.loadImage(url: model.artworkUrl512) {[weak self] data in
                
                guard let self else {return}
                
                
                DispatchQueue.main.async {
                    self.thumbNailImageView.image = UIImage(data: data)
                }
                
                
            }
        }
    }
}


extension LookUpViewController:UICollectionViewDelegate {
    

}

extension LookUpViewController:UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if collectionView == self.topCollectionView {
            return viewModel.ratingCase.count
        }
        else {
            return 0
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let model = viewModel.dataSource?.results.first else {
            return UICollectionViewCell()
        }
        
        if collectionView == self.topCollectionView {
            
            switch viewModel.ratingCase[indexPath.row] {
                
            case .starRating:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LookUpRatingCell", for: indexPath) as? LookUpRatingCell else {
                    return UICollectionViewCell()
                }
                
                cell.update(numberOfRating: model.userRatingCount, rating: model.averageUserRating)
                return cell
                
            case .age,.chart:
                let type = viewModel.ratingCase[indexPath.row]
                
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LookUpTextCell", for: indexPath) as? LookUpTextCell else {
                    return UICollectionViewCell()
                }
                
                if type == .age {
                    cell.update(title: "연령", content: "4+", subTitle: "세")
                }
                
                else {
                    cell.update(title: "차트", content: "#?", subTitle: "음악")
                }
                
          
                return cell
                
            case  .dev:
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LookUpDevCell", for: indexPath) as? LookUpDevCell else {
                    return UICollectionViewCell()
                }
                
                cell.update(developer: model.artistName)
                
                return cell
                
                
            case .lan :
                
                guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "LookUpNoLineTextCell", for: indexPath) as? LookUpNoLineTextCell else {
                    return UICollectionViewCell()
                }
                
              
                cell.update(title: "언어", content: model.languageCodesISO2A.first!, subTitle: "+ 1개 언어" )
                    return cell
            }
            
            
            
        }
        else {
            return UICollectionViewCell()
        }
        
    }
    
    
}
