//
//  SearchResultViewController.swift
//  UikitPlayground
//
//  Created by yongbeomkwak on 2023/06/08.
//

import UIKit

class SearchResultViewController: BaseViewController,ViewControllerFromStoryBoard {
    
    //DiSelected 만들어주기
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
        tableView.delegate = self
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

extension SearchResultViewController: UITableViewDelegate{
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        
        let width = (UIScreen.main.bounds.width - CGFloat(60))/CGFloat(3)
        let height = width * 696 / 392
        
        return 120 + height
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        
        let id = viewModel.dataSource.results[indexPath.row].trackID
         
        let LookUpVc = LookUpViewController.viewController(viewModel: LookupViewModel(id: id ))
        self.navigationController?.pushViewController(LookUpVc, animated: true)
        
        
    }
}
