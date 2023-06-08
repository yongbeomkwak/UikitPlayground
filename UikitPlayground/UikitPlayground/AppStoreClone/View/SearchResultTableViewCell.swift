//
//  SearchResultTableViewCell.swift
//  UikitPlayground
//
//  Created by yongbeomkwak on 2023/06/08.
//

import UIKit

class SearchResultTableViewCell: UITableViewCell {

    @IBOutlet weak var thumbNailImage: UIImageView!
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitle: UILabel!
    
    @IBOutlet weak var firstStarImageView: UIImageView!
    @IBOutlet weak var secondStarImageView: UIImageView!
    @IBOutlet weak var thirdStarImageView: UIImageView!
    @IBOutlet weak var fourthStarImageView: UIImageView!
    @IBOutlet weak var fifthStarImageView: UIImageView!
    
    @IBOutlet weak var numberOfReviewsLabel: UILabel!
    
    @IBOutlet weak var installButton: UIButton!
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var stars:[UIImageView] = [UIImageView(),UIImageView(),UIImageView(),UIImageView(),UIImageView()]
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.thumbNailImage.layer.cornerRadius = 12
        self.thumbNailImage.clipsToBounds = true
        
        self.titleLabel.font = .systemFont(ofSize: 15, weight: .medium)
        self.titleLabel.textColor = .black
        
        self.subTitle.font = .systemFont(ofSize: 10, weight: .light)
        self.subTitle.textColor = .black
        
        self.numberOfReviewsLabel.font = .systemFont(ofSize: 8, weight: .light)
        self.numberOfReviewsLabel.textColor = .gray
        
        self.installButton.setTitle("받기", for: .normal)
        self.installButton.tintColor = .systemBlue
        self.installButton.layer.cornerRadius = 24
        
        stars[0] = firstStarImageView
        stars[1] = secondStarImageView
        stars[2] = thirdStarImageView
        stars[3] = fourthStarImageView
        stars[4] = fifthStarImageView
        
        initializeStar()
    }
    
    private func initializeStar() {
        for star in stars {
            star.tintColor = .systemGray4
            star.image = UIImage(systemName: "star")
        }
    }



}
