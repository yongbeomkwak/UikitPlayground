//
//  RecentSearchResultTableViewCell.swift
//  UikitPlayground
//
//  Created by yongbeomkwak on 2023/06/04.
//

import UIKit

class RecentSearchResultTableViewCell: UITableViewCell {

    @IBOutlet weak var magnifyingGlassImageVIew: UIImageView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
    }

}


extension RecentSearchResultTableViewCell {
    
    public func update(text:String){
        
        label.text = text
        
        
    }
}
