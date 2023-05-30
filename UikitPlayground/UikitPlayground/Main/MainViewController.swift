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
    

    override func viewDidLoad() {
        super.viewDidLoad()
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
            dest = UIViewController()
        }
        
        
        self.navigationController?.pushViewController(dest!, animated: true)
    }
    
    
}
