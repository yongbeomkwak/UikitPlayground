//
//  GitViewController.swift
//  UikitPlayground
//
//  Created by yongbeomkwak on 2023/06/20.
//

import UIKit
import RxSwift

class GitViewController: BaseViewController,ViewControllerFromStoryBoard {

    @IBOutlet weak var talbeView: UITableView!
    let searchController = UISearchController(searchResultsController: nil)
    
    let disposeBag = DisposeBag()
    
    var viewModel:GitViewModel!
    lazy var input = GitViewModel.Input()
    lazy var output = viewModel.transform(from: input)
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setNavigationItem()
        configureUI()
        bindRx()
        
    }
    

    public static func viewController() -> GitViewController {
        
        let vc = GitViewController.viewController(storyBoardName: "GitClone", bundle: .main)
        
        vc.viewModel = GitViewModel()
        
        
        return vc
    }

}


extension GitViewController {
    
    private func setNavigationItem(){
        self.navigationItem.setHidesBackButton(true, animated: true)
        setSearchController()
        self.navigationItem.hidesSearchBarWhenScrolling = false //기본값은 true이며 스크롤시에도 searchBar를 계속 보고싶다면 false로 지정하면 됩니다.
        
    }
    
    private func setSearchController() {
       
        searchController.searchBar.placeholder = "저장소 이름을 입력해주세요"
        searchController.obscuresBackgroundDuringPresentation = false // 검색 중에 Background를 어둡게 할건지 결정하는 Boolean값입니다.
        
        searchController.searchResultsUpdater = self
        searchController.searchBar.delegate = self // 리턴 키 인식을 위한 델리게이트
        self.navigationItem.searchController = searchController
    }
    
    private func configureUI(){
        
        self.talbeView.dataSource = self
        self.talbeView.delegate = self
        
        
    }
    
    private func bindRx(){
        
        output.dataSource.subscribe(onNext: {
            DEBUG_LOG($0)
        })
        .disposed(by:disposeBag)
        
    }
    
}

extension GitViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 0 
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "GitRepoTableViewCell") as? GitRepoTableViewCell else {
            return UITableViewCell()
        }
        
        //
        
        return cell
    }
    
    
}

extension GitViewController:UITableViewDelegate {
    
}

extension GitViewController: UISearchResultsUpdating {
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let text = searchController.searchBar.text else {return}
        
        input.text
            .onNext(text)

    }
}


extension GitViewController: UISearchBarDelegate{
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        let text = searchBar.text!

        
    }
}
