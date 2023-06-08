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
        configureUI()
    }
    

    public static func viewController(viewModel:SearchResultViewModel) -> SearchResultViewController {
        
        let vc = SearchResultViewController.viewController(storyBoardName: "Appstore", bundle: .main)
        vc.viewModel = viewModel
        
        
        
        return vc
    }


}

extension SearchResultViewController{
    
    private func configureUI(){
        tableView.dataSource = self
        //tableView.delegate = self
    }
}

extension SearchResultViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.dataSource.resultCount
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SearchResultTableViewCell") as? SearchResultTableViewCell else {
            return UITableViewCell()
        }
        
        let row = indexPath.row
        
        cell.update(model: viewModel.dataSource.results[row])
    
        
        return cell
    }
    
    
    
}
