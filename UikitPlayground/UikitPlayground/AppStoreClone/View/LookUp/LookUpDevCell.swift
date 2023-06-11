//
//  LookUpDevCell.swift
//  UikitPlayground
//
//  Created by yongbeomkwak on 2023/06/10.
//

import UIKit

class LookUpDevCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    @IBOutlet weak var subTitleLabel: UILabel!
    
    @IBOutlet weak var seperatorView: UIView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.titleLabel.font = .systemFont(ofSize: 15, weight: .light)
        self.titleLabel.textColor = .systemGray2
        
        self.imageView.image =  UIImage(systemName: "person.crop.square")
        self.imageView.tintColor = .black
        
        self.subTitleLabel.font = .systemFont(ofSize: 15, weight: .light)
        self.subTitleLabel.textColor = .systemGray2
        
        self.seperatorView.backgroundColor = .systemGray
        
        
    }
}

extension LookUpDevCell {
    
    public func update(developer:String)
    {
        self.subTitleLabel.text = developer
    }
}


