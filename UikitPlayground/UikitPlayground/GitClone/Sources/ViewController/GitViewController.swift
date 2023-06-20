//
//  GitViewController.swift
//  UikitPlayground
//
//  Created by yongbeomkwak on 2023/06/20.
//

import UIKit

class GitViewController: BaseViewController,ViewControllerFromStoryBoard {

    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var talbeView: UITableView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    

    public static func viewController() -> GitViewController {
        
        let vc = GitViewController.viewController(storyBoardName: "GitClone", bundle: .main)
        
        
        
        return vc
    }

}
