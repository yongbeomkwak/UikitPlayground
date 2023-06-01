//
//  ViewController.swift
//  UikitPlayground
//
//  Created by yongbeomkwak on 2023/05/19.
//

import UIKit

public enum Subject:String {
    case imageCaching
}


class MainViewController: UIViewController,ViewControllerFromStoryBoard {
    
    let subjects:[Subject] = [.imageCaching]
    
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        DEBUG_LOG("FirstVC WillAppear")
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        DEBUG_LOG("FirstVC WillDisappear")
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(animated)
        DEBUG_LOG("FirstVC DidDisappear")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        DEBUG_LOG("FirstVC DidLoad")
        configureUI()
        // Do any additional setup after loading the view.
    }
    
    public static func viewController() -> MainViewController {
        
        let vc = MainViewController.viewController(storyBoardName: "Main", bundle: .main)
        
        
        return vc
    }
    
    
    


}

extension MainViewController {
    
    private func configureUI(){
        self.tableView.delegate = self
        self.tableView.dataSource = self
    }
    
}

extension MainViewController:UITableViewDelegate {
    
}

extension MainViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return subjects.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "SubjectTableViewCell", for: indexPath) as? SubjectTableViewCell else {
            return UITableViewCell()
        }
        
        let row = indexPath.row
        
        cell.update(s: subjects[row])
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        //tableView.deselectRow(at: indexPath, animated: true)
        
        DEBUG_LOG(subjects[indexPath.row].rawValue)
        
        let dest:UIViewController?
        switch subjects[indexPath.row] {
            
        case .imageCaching:
            dest = ImageCachingViewController.viewController()
        }
        
       
        
        self.navigationController?.pushViewController(dest!, animated: true)
        /*
         FirstVC DidLoad
         FirstVC WillAppear
         SecondVC DidLoad
         FirstVC WillDisappear
         SecondVC WillAppear
         FirstVC DidDisappear

         dismiss
         SecondVC WillDisappear
         FirstVC WillAppear
         SecondVC DidDisappear
         
        */
        
    }
    
    
}
