//
//  WarningView.swift
//  UikitPlayground
//
//  Created by yongbeomkwak on 2023/06/04.
//

import UIKit

class WarningView: UIView {

    override init(frame: CGRect) { //코드쪽에서 생성 시 호출
        super.init(frame: frame)
        self.setupView()
    }
    
    required init?(coder aDecoder:NSCoder) { //StoryBoard에서 호출됨
        super.init(coder: aDecoder)
        self.setupView()
    }
    
    private func setupView(){
        if let view = Bundle.main.loadNibNamed("WarningView", owner: self,options: nil)!.first as? UIView{
                view.frame = self.bounds
                //view.backgroundColor = .gray
                view.layoutIfNeeded() //드로우 사이클을 호출할 때 쓰임
                self.addSubview(view)
        }
        

    }

}
