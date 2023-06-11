//
//  LookUpCollectionViewCell.swift
//  UikitPlayground
//
//  Created by yongbeomkwak on 2023/06/10.
//

import UIKit

class LookUpRatingCell: UICollectionViewCell {
    
    @IBOutlet weak var reviewsLabel: UILabel!
    
    @IBOutlet weak var ratingLabel: UILabel!
    @IBOutlet weak var firstStarImageView: UIImageView!
    @IBOutlet weak var secondStarImageView: UIImageView!
    @IBOutlet weak var thirdStarImageView: UIImageView!
    @IBOutlet weak var fourthStarImageView: UIImageView!
    @IBOutlet weak var fifthStarImageView: UIImageView!
    
    @IBOutlet weak var seperatorView: UIView!
    var stars:[UIImageView] = [UIImageView(),UIImageView(),UIImageView(),UIImageView(),UIImageView()]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.reviewsLabel.font = .systemFont(ofSize: 15, weight: .light)
        self.reviewsLabel.textColor = .systemGray2
        
        self.ratingLabel.font = .systemFont(ofSize:25, weight: .bold)
        self.ratingLabel.textColor = .systemGray
        
        self.seperatorView.backgroundColor = .systemGray
    
        
        stars[0] = firstStarImageView
        stars[1] = secondStarImageView
        stars[2] = thirdStarImageView
        stars[3] = fourthStarImageView
        stars[4] = fifthStarImageView
        
        initializeStar()
        
    }
}

extension LookUpRatingCell {
    
    public func update(numberOfRating:Int,rating:Double){
        
        reviewsLabel.text = convertRatingToKor(rate: numberOfRating)
        
        ratingLabel.text = "\(round(rating))"
        
        var index:Int = 0
        for s in getStarStatus(rate: rating) {
            
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
        
        
    }
    
    
    private func convertRatingToKor(rate:Int) -> String {


        
        let len:Int = String(rate).count
        
        
        if len < 4 {
            return "\(rate)개의 평가"
        }
        

        
        switch len {

            case 4:
                return "\(round(Double(rate / 100))/10)천개의 평가" // 반올림 후 , 다시 나눔
        
            default:
                return "\(round(Double(rate / 1000))/10)만개의 평가"

        }



    }
    
    
    private func getStarStatus(rate:Double) -> [Star] {
        
        let roundedValue = Int(round(rate*10)) // 소수 점 2째 자리에서 반올림
        
        let number = roundedValue / 10 // 정수
        let decimal = roundedValue % 10 // 소수점
        
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
    
    private func initializeStar() {
        for star in stars {
            star.tintColor = .systemGray4
            star.image = UIImage(systemName: "star")
        }
    }
}
