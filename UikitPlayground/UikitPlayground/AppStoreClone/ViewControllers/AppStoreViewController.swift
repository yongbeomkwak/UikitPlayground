//
//  AppStoreViewController.swift
//  UikitPlayground
//
//  Created by yongbeomkwak on 2023/06/04.
//

import UIKit

class AppStoreViewController: UIViewController,ViewControllerFromStoryBoard,ContainerViewType {
    @IBOutlet weak public var contentView: UIView!
    
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    private var viewModel:AppStoreViewModel!
    fileprivate lazy var input = AppStoreViewModel.Input()
    fileprivate lazy var output = viewModel.transform(from: input)
    fileprivate lazy var beforeVc = RecentSearchResultViewController.viewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setNavigationItem()
        configureUI()
        
    }
    
    public static func viewController() -> AppStoreViewController {
        
        let vc = AppStoreViewController.viewController(storyBoardName: "Appstore", bundle: .main)
        vc.viewModel = AppStoreViewModel()
        return vc
    }



}

extension AppStoreViewController{
    
    private func setNavigationItem(){
        self.navigationItem.setHidesBackButton(true, animated: true)
        self.navigationItem.title = "검색"
        setSearchController()
        self.navigationItem.hidesSearchBarWhenScrolling = false //기본값은 true이며 스크롤시에도 searchBar를 계속 보고싶다면 false로 지정하면 됩니다.
        
    }
    
    private func setSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.searchBar.placeholder = "게임,앱,스토리 등"
        searchController.obscuresBackgroundDuringPresentation = false // 검색 중에 Background를 어둡게 할건지 결정하는 Boolean값입니다.
        
        searchController.searchResultsUpdater = self
        
        self.navigationItem.searchController = searchController
    }
    
    private func configureUI(){
        self.activityIndicator.isHidden = true
        
        self.add(asChildViewController: beforeVc)
    
    }
    
}

extension AppStoreViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
    }
}
