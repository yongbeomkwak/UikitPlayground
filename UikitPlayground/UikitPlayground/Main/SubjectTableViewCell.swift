//
//  SubjectTableViewCell.swift
//  UikitPlayground
//
//  Created by yongbeomkwak on 2023/05/30.
//

import UIKit

class SubjectTableViewCell: UITableViewCell {

   
    @IBOutlet weak var label: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

}

extension SubjectTableViewCell {
    
    func update(s:Subject){
        self.label.text = s.rawValue
    }
    
}

