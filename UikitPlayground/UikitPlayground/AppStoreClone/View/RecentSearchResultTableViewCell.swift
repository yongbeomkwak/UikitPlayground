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
    
    var model:String = ""
    
    @IBAction func removeAction(_ sender: Any) {
        DEBUG_LOG(model)
        PreferenceManager.shared.removeRecentRecords(word: model)
        
    }
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
    
        model = text
        label.text = text
        
        
    }
}
