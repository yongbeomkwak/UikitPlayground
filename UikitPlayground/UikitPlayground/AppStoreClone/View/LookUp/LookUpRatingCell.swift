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
    
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
    }
}
