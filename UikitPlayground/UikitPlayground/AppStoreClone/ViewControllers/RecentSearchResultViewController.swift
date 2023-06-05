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
        PreferenceManager.shared.addRecentRecords(word: "Hello")
        PreferenceManager.shared.addRecentRecords(word: "Hello2")
        PreferenceManager.shared.addRecentRecords(word: "Hello3")
        PreferenceManager.shared.addRecentRecords(word: "Ad")
        PreferenceManager.shared.addRecentRecords(word: "Blo3")
        
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
    
    public func filtredBy(text:String){
        viewModel.filteredBy(text: text)
        tableView.reloadData()
    }
}

extension RecentSearchResultViewController:UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        guard let parent = self.parent as? AppStoreViewController else  {
            return nil
        }
        
        if parent.isFiltering {
            
            if viewModel.filteredData.isEmpty {
                let header = WarningView()
                return header
            }
            
            else {
                let  header = RecentRecordHeaderView()
                 
                 header.completionHandler = { [weak self] in
                     
                     guard let self else {return}
                     
                     PreferenceManager.recentRecords = nil
                     self.viewModel.filteredData.removeAll()
                     tableView.reloadData()
                 }
                 
                 return header
            }
        }
        
        if PreferenceManager.recentRecords?.isEmpty ?? true{
           
            let header = WarningView()
            return header
        }
        else {
            
           let  header = RecentRecordHeaderView()
            
            header.completionHandler = {
                PreferenceManager.recentRecords = nil
                tableView.reloadData()
            }
            
            return header
        }
        
        
    
    }
    
 
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        guard let parent = self.parent as? AppStoreViewController else  {
            return 0
        }
        
      return  parent.isFiltering ? viewModel.filteredData.count :  PreferenceManager.recentRecords?.count ?? 0
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let parent = self.parent as? AppStoreViewController else  {
            return UITableViewCell()
        }
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecentSearchResultTableViewCell", for: indexPath) as? RecentSearchResultTableViewCell else {
            return UITableViewCell()
        }
        
        var data:[String]
        guard let savedData = PreferenceManager.recentRecords else { return UITableViewCell()}
        
        if parent.isFiltering {
            data = viewModel.filteredData
        }
        else {
            data = savedData
        }
        
  
       
        cell.update(text: data[indexPath.row])
        cell.delegate = self
        
        
        return cell
    }

    
}

extension RecentSearchResultViewController:UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        guard let parent = self.parent as? AppStoreViewController else  {
            return
        }
        var data:[String]
        guard let savedData = PreferenceManager.recentRecords else { return }
        
        if parent.isFiltering {
            data = viewModel.filteredData
        }
        else {
            data = savedData
        }
        

        DEBUG_LOG(data[indexPath.row])
    }
}

extension RecentSearchResultViewController:RecentSearchResultTableViewCellDelegate{
    func remove(text: String) {
        PreferenceManager.shared.removeRecentRecords(word: text)
        viewModel.remove(text: text)
        tableView.reloadData()
    }
}
