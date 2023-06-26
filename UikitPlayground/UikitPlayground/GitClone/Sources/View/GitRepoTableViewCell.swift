//
//  GitRepoTableViewCell.swift
//  UikitPlayground
//
//  Created by yongbeomkwak on 2023/06/20.
//

import UIKit

class GitRepoTableViewCell: UITableViewCell {

    @IBOutlet weak var repoTitleLabel: UILabel!
    @IBOutlet weak var starImageView: UIImageView!
    @IBOutlet weak var numStarLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        self.starImageView.image = UIImage(systemName: "star.fill")
        self.starImageView.tintColor = .yellow
        
        self.repoTitleLabel.font = .systemFont(ofSize: 20, weight: .black)
        
        self.numStarLabel.font = .systemFont(ofSize: 10, weight: .regular)
        self.numStarLabel.tintColor = .systemGray4
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        
    }
    


}

extension GitRepoTableViewCell {
    
    
    func update(model:RepoModel){
        
        
        self.repoTitleLabel.text = model.name
        self.numStarLabel.text = "\(model.starCount)"
    }
    
}
