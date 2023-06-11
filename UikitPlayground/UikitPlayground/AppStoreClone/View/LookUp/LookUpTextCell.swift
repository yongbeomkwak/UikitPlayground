//
//  LookUpNoLineTextCell.swift
//  UikitPlayground
//
//  Created by yongbeomkwak on 2023/06/10.
//

import UIKit

class LookUpTextCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    
    @IBOutlet weak var resultLabel: UILabel!
    
    @IBOutlet weak var subTitleLaebl: UILabel!
    
    @IBOutlet weak var seperatorView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.titleLabel.font = .systemFont(ofSize: 15, weight: .light)
        self.titleLabel.textColor = .systemGray2
        
        self.resultLabel.font = .systemFont(ofSize:25, weight: .bold)
        self.resultLabel.textColor = .systemGray
        
        self.subTitleLaebl.font = .systemFont(ofSize: 15, weight: .light)
        self.subTitleLaebl.textColor = .systemGray2
        
        self.seperatorView.backgroundColor = .systemGray
        
        
    }
    
}

extension LookUpTextCell {
    public func update(title:String, content:String, subTitle:String)
    {
        self.titleLabel.text = title
        self.resultLabel.text = content
        self.subTitleLaebl.text = subTitle
    }
}
