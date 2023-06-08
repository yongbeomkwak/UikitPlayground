//
//  SearchResultViewController.swift
//  UikitPlayground
//
//  Created by yongbeomkwak on 2023/06/08.
//

import UIKit

class SearchResultViewController: BaseViewController,ViewControllerFromStoryBoard {
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel:SearchResultViewModel!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    

    public static func viewController(viewModel:SearchResultViewModel) -> SearchResultViewController {
        
        let vc = SearchResultViewController.viewController(storyBoardName: "Appstore", bundle: .main)
        vc.viewModel = viewModel
        
        
        
        return vc
    }


}

extension SearchResultViewController{
    
    private func configureUI(){
        
    }
}
