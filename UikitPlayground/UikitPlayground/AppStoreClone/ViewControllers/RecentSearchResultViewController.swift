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
    }
    
}

extension RecentSearchResultViewController:UITableViewDataSource {
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        PreferenceManager.recentRecords?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "RecentSearchResultTableViewCell", for: indexPath) as? RecentSearchResultTableViewCell else {
            return UITableViewCell()
        }
        
        
        guard let data = PreferenceManager.recentRecords else { return UITableViewCell()}
        cell.update(text: data[indexPath.row])
        
        
        return cell
    }
    
    
}

extension RecentSearchResultViewController:UITableViewDelegate {
    
}
