//
//  ViewController.swift
//  todo_app_firebase
//
//  Created by Alperen Akarslan on 23.08.2023.
//

import UIKit
import Firebase

class ViewController: UITableViewController {
    
    // Properties
    
    var todoItems = [TodoItem]() {
        didSet {
            print("Todo items was set")
            tableView.reloadData()
        }
    }
    
    let reuseIdentifier = "TodoCell"
    
    lazy var createNewButton: UIButton = {
        let button = UIButton()
        button.tintColor = .black
        button.backgroundColor = .lightGray
        button.setImage(UIImage(systemName: "plus.circle"), for: .normal)
        button.layer.zPosition = CGFloat(Float.greatestFiniteMagnitude)
        button.addTarget(self, action: #selector(createNewTodo), for: .touchUpInside)
        return button
       
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureTableView()
        fetchItems()
    }
    
    // Selectors
    
    @objc func createNewTodo(){
        let vc = CreateTodoController()
        present(vc, animated: true, completion: nil)
    }
    
    // API
    
    private func fetchItems() {
        //        PostService.shared.fetchAllItems()
        PostService.shared.fetchAllItems{ (allItems) in
            self.todoItems = allItems
        }
    }
    
    
    // Helper Func
    
    func configureTableView(){
        tableView.backgroundColor = .white
        tableView.register(TodoCell.self, forCellReuseIdentifier: reuseIdentifier)
        tableView.rowHeight = 75
        tableView.separatorColor = .black
        tableView.separatorInset = UIEdgeInsets(top: 0, left: 16, bottom: 0, right: 16)
        tableView.tableFooterView = UIView()
        
        // Create new todo
        tableView.addSubview(createNewButton)
        createNewButton.anchor(bottom: tableView.safeAreaLayoutGuide.bottomAnchor, right: tableView.safeAreaLayoutGuide.rightAnchor,
        paddingBottom: 16, paddingRight: 16, width: 56, height: 56)
        createNewButton.layer.cornerRadius = 56 / 2
        createNewButton.alpha = 1
}
}

// UITableViewDelegate - UITableViewDataSource
extension ViewController{
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoItems.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: reuseIdentifier, for: indexPath) as? TodoCell
        else {
            return UITableViewCell()
        }
        
        cell.todoItem = todoItems[indexPath.row]
        
        return cell
    }
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        // Update status of the cell
        // Incomplete -> Finished
        
        let todoItem = todoItems[indexPath.row]
        
        PostService.shared.updateItemStatus(todoId: todoItem.id, isComplete: true) { (err, ref) in
            self.tableView.deselectRow(at: indexPath, animated: true)
            self.fetchItems()
        }
    }
}

