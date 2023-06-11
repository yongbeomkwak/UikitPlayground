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
    
    @IBOutlet weak var newFunctionLabel: UILabel!
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
        
        self.newFunctionLabel.lineBreakMode = .byCharWrapping
        /*
         컨테이너에 맞지 않는 단락의 줄 바꿈 모드입니다.
         🍎 레이블의 텍스트를 줄 바꿈하고 자르는 기술이다.
         
         1. .byWordWrapping
        - Character Wrap과 비슷하지만, 개별 문자가 아니라 단어 기준으로 줄바꿈합니다. 즉, 단어 중간을 끊어 줄바꿈하지 않는다는 뜻입니다. 이 때문에 단어 전체가 들어갈 공간이 충분하지 않으면 남은 공간이 있더라도 다음 라인으로 줄바꿈하는 특성이 있습니다.
         
         2. .byCharWrapping
        - 개별 문자 단위로 줄바꿈합니다. 하나의 단어가 완전히 끝나지 않았어도 라인의 끝에 도착하면 다음 라인으로 줄을 바꾸어 나머지 문자를 계속 출력합니다. 물론 Line 속성에서 설정된 라인 수를 넘어서면 나머지 텍스트는 표시하지 않습니다
         
         3. .byClipping
        - 줄이 텍스트 컨테이너의 가장자리를 지나 확장되지 않음을 나타내는 값이다.
         
         4.  .byTruncatingHead
         - 콘텐츠 출력에 필요한 라인 수보다 레이블에 설정된 Line 속성이 적을 경우, 마지막 라인의 첫 머리 텍스트 일부를 말줄임표로 처리합니다.
         
         5. Truncate Middle
         
         - 마지막 라인의 텍스트 중간을 말줄임표로 처리하고 라인의 앞과 뒤 텍스트를 보존하는 방식입니다.
         
            즉, 앞부분을 잘라내고 텍스트의 뒷부분을 보존하는 방식으로 콘텐츠를 표현합니다.
         
         
         6. Truncate Tail

         - 마지막 라인의 뒷부분을 잘라내어 말줄임표로 처리합니다. (가장 익숙한 처리 방식)
            
         */
        
    }
    
    func bindCompletion() {
        viewModel.fetchData { [weak self] result in

            guard let self else {return}
            guard let model = result.results.first else {return}
            
            DispatchQueue.main.async {
                self.titleLabel.text = model.trackName
                self.developerNameLabel.text = model.artistName
                self.newFunctionLabel.text = model.releaseNotes
                self.topCollectionView.dataSource = self
                self.topCollectionView.delegate = self
                
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
