//
//  RecentRecordHeaderView.swift
//  UikitPlayground
//
//  Created by yongbeomkwak on 2023/06/04.
//

import UIKit

class RecentRecordHeaderView: UIView {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var removeAllButton: UIButton!
    
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
        
        if let view = Bundle.main.loadNibNamed("RecentRecordHeaderView", owner: self,options: nil)!.first as? UIView{
                view.frame = self.bounds
                view.layoutIfNeeded() //드로우 사이클을 호출할 때 쓰임
                self.addSubview(view)
        }
        
        self.titleLabel.text = "최근 검색"
        self.titleLabel.textColor = .black
        self.titleLabel.font = .systemFont(ofSize: 18, weight: .bold)
        self.removeAllButton.setTitle("전체 삭제", for: .normal)
        self.removeAllButton.tintColor = .lightGray

    }

}
