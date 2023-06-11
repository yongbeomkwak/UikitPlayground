//
//  LookUpScreenShotCollectionViewCell.swift
//  UikitPlayground
//
//  Created by yongbeomkwak on 2023/06/11.
//

import UIKit

class LookUpScreenShotCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var imageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        self.imageView.layer.cornerRadius = 12
        self.imageView.clipsToBounds = true
    }
}

extension LookUpScreenShotCollectionViewCell {
    
    public func update(_ url:String){
        
        
        ImageCacheManager.shared.loadImage(url: url) { data in
            
            DispatchQueue.main.async { [weak self] in
                
                guard let self else {return}
                
                self.imageView.image = UIImage(data: data)
            }
            
        }
        
        
    }
    
}
