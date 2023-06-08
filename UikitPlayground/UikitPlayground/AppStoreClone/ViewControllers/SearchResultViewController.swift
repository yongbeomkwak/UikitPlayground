//
//  SearchResultViewController.swift
//  UikitPlayground
//
//  Created by yongbeomkwak on 2023/06/08.
//

import UIKit

class SearchResultViewController: BaseViewController,ViewControllerFromStoryBoard {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

    public static func viewController() -> SearchResultViewController {
        
        let vc = SearchResultViewController.viewController(storyBoardName: "Appstore", bundle: .main)
        return vc
    }


}

extension SearchResultViewController{
    
    private func configureUI(){
        
    }
}
