//
//  SearchResultTableViewCell.swift
//  UikitPlayground
//
//  Created by yongbeomkwak on 2023/06/08.
//

import UIKit

public enum Star {
    
    case full
    case half
    case empty
    
}

class SearchResultTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbNailImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    
    @IBOutlet weak var firstStarImageView: UIImageView!
    @IBOutlet weak var secondStarImageView: UIImageView!
    @IBOutlet weak var thirdStarImageView: UIImageView!
    @IBOutlet weak var fourthStarImageView: UIImageView!
    @IBOutlet weak var fifthStarImageView: UIImageView!
    
    @IBOutlet weak var numberOfRatingLabel: UILabel!
    
    @IBOutlet weak var installButton: UIButton!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var stars:[UIImageView] = [UIImageView(),UIImageView(),UIImageView(),UIImageView(),UIImageView()]
    var dataSource:[String] = []
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.thumbNailImage.layer.cornerRadius = 12
        self.thumbNailImage.clipsToBounds = true
        
        self.titleLabel.font = .systemFont(ofSize: 20, weight: .regular)
        self.titleLabel.textColor = .black
        
        self.subTitle.font = .systemFont(ofSize: 15, weight: .light)
        self.subTitle.textColor = .black
        
        self.numberOfRatingLabel.font = .systemFont(ofSize: 10, weight: .light)
        self.numberOfRatingLabel.textColor = .gray
        
        self.installButton.setTitle("받기", for: .normal)
        self.installButton.tintColor = .systemBlue
        self.installButton.layer.cornerRadius = 12.5
        self.installButton.clipsToBounds = true

        
        stars[0] = firstStarImageView
        stars[1] = secondStarImageView
        stars[2] = thirdStarImageView
        stars[3] = fourthStarImageView
        stars[4] = fifthStarImageView
        
        initializeStar()
        
        collectionView.dataSource = self
        collectionView.delegate = self

    }
    
    private func initializeStar() {
        for star in stars {
            star.tintColor = .systemGray4
            star.image = UIImage(systemName: "star")
        }
    }
    
    private func convertRatingToKor(rate:Int) -> String {


        
        let len:Int = String(rate).count
        
        
        if len < 4 {
            return String(rate)
        }
        

        
        switch len {

            case 4:
                return "\(round(Double(rate / 100))/10)천" // 반올림 후 , 다시 나눔
        
            default:
                return "\(round(Double(rate / 1000))/10)만"

        }



    }
    
    
    private func getStarStatus(rate:Double) -> [Star] {
        
        let roundedValue = Int(round(rate*10)) // 소수 점 2째 자리에서 반올림
        
        let number = roundedValue / 10 // 정수
        let decimal = roundedValue % 10 // 소수점
        
        DEBUG_LOG("N: \(number) D: \(decimal) ")
        var result:[Star] = [.empty,.empty,.empty,.empty,.empty]
        
        
        for i in 0..<number {  // 별 꽉 채우기
            result[i] = .full
        }
       
        if decimal > 6 {
            for i in number..<5 {
                result[i] = .full
            }
        }
        
        else if decimal == 5 { // 4가 넘으면 half
            for i in number..<5 {
                result[i] = .half
            }
        }
        
        
        
        
        return result
        
    }
    
    
    public func update(model:SearchDetail){
        
        titleLabel.text = model.trackName
        subTitle.text = "\(model.trackID)"
        numberOfRatingLabel.text = convertRatingToKor(rate: model.userRatingCount)
        
        var index:Int = 0
        for s in getStarStatus(rate: model.averageUserRating) {
            
            switch s {
                case .full:
                    stars[index].image = UIImage(systemName: "star.fill")
                
                case .half:
                stars[index].image = UIImage(systemName: "star.leadinghalf.filled")
                
                case.empty:
                    continue
            }
            
            index += 1
        }
        

        ImageCacheManager.shared.loadImage(url:model.artworkUrl512) { [weak self] data in
            
            guard let self else {return}
            
            DispatchQueue.main.async { // UI작업  메인 스레드
                self.thumbNailImage.image = UIImage(data: data)
            }
           
            
        }
        
        
        dataSource = model.screenshotUrls
        collectionView.reloadData()
    }



}

extension SearchResultTableViewCell:UICollectionViewDelegate,UICollectionViewDelegateFlowLayout{

    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        let width = (UIScreen.main.bounds.width - CGFloat(60))/CGFloat(3)
        let height = width * 696 / 392
        
        return CGSize(width: width, height: height) // 컬렉션 뷰 셀 하나의 크기(너비,높이)
    }

//    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
//
//        // 스크롤이 끝까지 되었을 때 , collectinView 자체 인셋 설정
//        return UIEdgeInsets(top: 0, left: 30.0, bottom: 0, right: 30.0)
//    }

//    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumLineSpacingForSectionAt section: Int) -> CGFloat {
//        return 50.0 //셀 사이간격
//    }

//    public func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, minimumInteritemSpacingForSectionAt section: Int) -> CGFloat {
//        return 10.0
//    }

}

extension SearchResultTableViewCell:UICollectionViewDataSource{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return min(3,dataSource.count)
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ScreenShotCollectionViewCell", for: indexPath) as? ScreenShotCollectionViewCell else {
            return UICollectionViewCell()
            
        }
        
        let row = indexPath.row
        
        cell.update(url: dataSource[row])
        
        return cell
    }
}

