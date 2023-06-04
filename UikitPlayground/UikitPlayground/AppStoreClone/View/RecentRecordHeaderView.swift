//
//  RecentRecordHeaderView.swift
//  UikitPlayground
//
//  Created by yongbeomkwak on 2023/06/04.
//

import UIKit

class RecentRecordHeaderView: UIView {

    
    @IBAction func removeAll(_ sender: Any) {
        completionHandler?()
    }
    //1. 넘겨주는 연결통로
    var completionHandler: (() -> ())?
    
    override init(frame: CGRect) { //코드쪽에서 생성 시 호출
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder aDecoder:NSCoder) { //StoryBoard에서 호출됨
        super.init(coder: aDecoder)
        self.setupView()
    }
    
    private func setupView(){


    }

}
