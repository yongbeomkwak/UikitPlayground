//
//  RecentSearchResultViewController.swift
//  UikitPlayground
//
//  Created by yongbeomkwak on 2023/06/04.
//

import UIKit

class RecentSearchResultViewController: BaseViewController,ViewControllerFromStoryBoard {
    @IBOutlet weak var tableView: UITableView!
    
    lazy var viewModel = RecentSearchResultViewModel()
    override func viewDidLoad() {
        super.viewDidLoad()

        DEBUG_LOG("Before VC Load")
        
        configureUI()
        
    }
    
    public static func viewController() -> RecentSearchResultViewController {
        
        let vc = RecentSearchResultViewController.viewController(storyBoardName: "Appstore", bundle: .main)
        return vc
    }

}


extension RecentSearchResultViewController{
    
    private func configureUI(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = .systemGray6
       
        
    }
    
    public func filtredBy(text:String, isFiltering: Bool){
        viewModel.filteredBy(text: text, isFiltering: isFiltering)
        tableView.reloadData()
    }
}

extension RecentSearchResultViewController:UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        /// 데이터 소스가 비어잇을 경우 와 아닐경우를 나눠 헤더를 구분한다.
        
        if viewModel.dataSource.isEmpty {
            let header = WarningView()
            return header
        }
        
        else {
            let  header = RecentRecordHeaderView()
             
             header.completionHandler = { [weak self] in
                 
                 guard let self else {return}
                 
                 PreferenceManager.recentRecords = nil
                 self.viewModel.dataSource.removeAll()
                 tableView.reloadData()
             }
             
             return header
        }

    
    }
    
 
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return viewModel.dataSource.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        

        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecentSearchResultTableViewCell", for: indexPath) as? RecentSearchResultTableViewCell else {
            return UITableViewCell()
        }
    
       
        cell.update(text: viewModel.dataSource[indexPath.row])
        cell.delegate = self // 삭제 델리게이트
        
        
        return cell
    }

    
}

extension RecentSearchResultViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let parent = self.parent as? AppStoreViewController else  {
            return
        }

        parent.searchController.searchBar.text = viewModel.dataSource[indexPath.row] // 부모 뷰컨 검색창에 데이터 삽입 
    }
}

extension RecentSearchResultViewController:RecentSearchResultTableViewCellDelegate{
    func remove(text: String) {
        viewModel.remove(text: text)
        tableView.reloadData()
    }
}
