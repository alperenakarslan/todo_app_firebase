//
//  ViewController.swift
//  todo_app_firebase
//
//  Created by Alperen Akarslan on 23.08.2023.
//

import UIKit

class ViewController: UITableViewController {
    
    // Properties
    
    let reuseIdentifier = "TodoCell"

    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
    }
    
    // Helper Func
    func configureTableView(){
        tableView.backgroundColor = .lightGray
        tableView.register(TodoCell.self, forCellReuseIdentifier: reuseIdentifier)
    }

}

// UITableViewDelegate - UITableViewDataSource
extension ViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 7
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath)
        
        return cell
    }
}

