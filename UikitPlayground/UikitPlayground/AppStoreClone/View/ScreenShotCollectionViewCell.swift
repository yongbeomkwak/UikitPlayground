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
            update()
    }

    private func update(){
        
    }
    
}
