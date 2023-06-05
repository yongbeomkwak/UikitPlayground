//
//  RecentSearchResultTableViewCell.swift
//  UikitPlayground
//
//  Created by yongbeomkwak on 2023/06/04.
//

import UIKit


public protocol RecentSearchResultTableViewCellDelegate {
    
    func remove(text:String)
}


class RecentSearchResultTableViewCell: UITableViewCell {

    @IBOutlet weak var magnifyingGlassImageVIew: UIImageView!
    @IBOutlet weak var closeButton: UIButton!
    @IBOutlet weak var label: UILabel!
    
    
    @IBAction func removeAction(_ sender: Any) {
    
        delegate?.remove(text: self.label.text!)
      
    }
    
    var delegate:RecentSearchResultTableViewCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
        
        //magnifyingGlassImageVIew.image = UIImage(systemName: "magnifyingglass")

        label.font = UIFont.systemFont(ofSize: 15, weight: .light)
  //      closeButton.setImage(UIImage(systemName: "xmark"), for: .normal)
        closeButton.tintColor = .systemGray
    }

}


extension RecentSearchResultTableViewCell {
    
    public func update(text:String){
        
        label.text = text
        
        
    }
}
