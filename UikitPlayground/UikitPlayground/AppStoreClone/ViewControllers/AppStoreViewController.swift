//
//  AppStoreViewController.swift
//  UikitPlayground
//
//  Created by yongbeomkwak on 2023/06/04.
//

import UIKit

class AppStoreViewController: UIViewController,ViewControllerFromStoryBoard {

    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationItem()
        configureUI()
        
    }
    
    public static func viewController() -> AppStoreViewController {
        
        let vc = AppStoreViewController.viewController(storyBoardName: "Appstore", bundle: .main)
        
        return vc
    }



}

extension AppStoreViewController{
    
    private func setNavigationItem(){
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.navigationItem.title = "검색"
        setSearchController()
    }
    
    private func setSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "게임,앱,스토리 등"
        self.navigationItem.searchController = searchController
    }
    
    private func configureUI(){

        
    }
    
}
