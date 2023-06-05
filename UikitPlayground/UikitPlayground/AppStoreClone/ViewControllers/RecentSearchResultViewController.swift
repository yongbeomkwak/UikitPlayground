//
//  RecentSearchResultViewController.swift
//  UikitPlayground
//
//  Created by yongbeomkwak on 2023/06/04.
//

import UIKit

class RecentSearchResultViewController: UIViewController,ViewControllerFromStoryBoard {
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        DEBUG_LOG("Before VC Load")
        PreferenceManager.shared.addRecentRecords(word: "Hello")
        PreferenceManager.shared.addRecentRecords(word: "Hello2")
        PreferenceManager.shared.addRecentRecords(word: "Hello3")
        
        configureUI()
        
    }
    
    public static func viewController() -> RecentSearchResultViewController {
        
        let vc = RecentSearchResultViewController.viewController(storyBoardName: "Appstore", bundle: .main)
        return vc
    }

}


extension RecentSearchResultViewController{
    
    private func configureUI(){
        if #available(iOS 15.0, *) {
            self.tableView.sectionHeaderTopPadding = 0
//                    let tableViews = self.view.subviews.map { $0 as? UITableView }.compactMap { $0 }
//                    tableViews.forEach {
//                        $0.sectionHeaderTopPadding = 0
//                    }
        }
        self.tableView.delegate = self
        self.tableView.dataSource = self
        self.tableView.backgroundColor = .systemGray6
       
      //  tableView.tableHeaderView = header
        
        
    }
    
}

extension RecentSearchResultViewController:UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        
        
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
        PreferenceManager.recentRecords?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecentSearchResultTableViewCell", for: indexPath) as? RecentSearchResultTableViewCell else {
            return UITableViewCell()
        }
        
        
        
        guard let data = PreferenceManager.recentRecords else { return UITableViewCell()}
        cell.update(text: data[indexPath.row])
        cell.delegate = self
        
        
        return cell
    }

    
}

extension RecentSearchResultViewController:UITableViewDelegate {

}

extension RecentSearchResultViewController:RecentSearchResultTableViewCellDelegate{
    func remove(text: String) {
        PreferenceManager.shared.removeRecentRecords(word: text)
        tableView.reloadData()
    }
}
