//
//  ScreenShotCollectionViewCell.swift
//  UikitPlayground
//
//  Created by yongbeomkwak on 2023/06/08.
//

import UIKit

class ScreenShotCollectionViewCell: UICollectionViewCell {
    @IBOutlet weak var screenShotImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        self.screenShotImageView.layer.cornerRadius = 24
        self.screenShotImageView.clipsToBounds = true
        
    }

    public func update(url:String){
        
        
        ImageCacheManager.shared.loadImage(url: url) {[weak self] data in
            
            guard let self else {return}
            
            DispatchQueue.main.async {
                self.screenShotImageView.image = UIImage(data: data)
            }
            
            
        }
        
    }
    
}
