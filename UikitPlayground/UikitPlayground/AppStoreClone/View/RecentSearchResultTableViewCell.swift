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
    
    
    @IBAction func removeAction(_ sender: Any) {
    
        PreferenceManager.shared.removeRecentRecords(word: self.label.text!)
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

        if let view = Bundle.main.loadNibNamed("WarningView", owner: self,options: nil)!.first as? UIView{
                view.frame = self.bounds
                view.layoutIfNeeded() //드로우 사이클을 호출할 때 쓰임
                self.addSubview(view)
        }
        
        label.text = text
        
        
    }
}
