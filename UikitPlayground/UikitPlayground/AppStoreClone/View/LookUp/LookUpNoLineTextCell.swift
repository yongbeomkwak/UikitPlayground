//
//  LookUpNoLineTextCell.swift
//  UikitPlayground
//
//  Created by yongbeomkwak on 2023/06/10.
//

import UIKit

class LookUpNoLineTextCell: UICollectionViewCell {
    
    @IBOutlet weak var languageTitleLabel: UILabel!
    
    @IBOutlet weak var langagueLabel: UILabel!
    
    @IBOutlet weak var langagueSubTitle: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        self.languageTitleLabel.font = .systemFont(ofSize: 15, weight: .light)
        self.languageTitleLabel.textColor = .systemGray2
        
        self.langagueLabel.font = .systemFont(ofSize:25, weight: .bold)
        self.langagueLabel.textColor = .systemGray
        
        self.langagueSubTitle.font = .systemFont(ofSize: 15, weight: .light)
        self.langagueSubTitle.textColor = .systemGray2
        
        
    }
    
}


extension LookUpNoLineTextCell {
    
    public func update(title:String, content:String, subTitle:String)
    {
        self.languageTitleLabel.text = title
        self.langagueLabel.text = content
        self.langagueSubTitle.text = subTitle
    }
}
