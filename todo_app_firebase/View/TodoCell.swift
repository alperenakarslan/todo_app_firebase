//
//  TodoCell.swift
//  todo_app_firebase
//
//  Created by Alperen Akarslan on 23.08.2023.
//

import UIKit

class TodoCell: UITableViewCell {
    
    // Properties
    
    var todoItem: TodoItem? {
        didSet {
            titleLabel.text = todoItem?.title
            
            if let isComplete = todoItem?.isComplete, isComplete {
                statusLabel.text = "Status : Completed"
                statusLabel.textColor = UIColor(red: 26/255, green: 93/255, blue: 26/255, alpha: 1.0)
            } else {
                statusLabel.text = "Status : Incompleted"
                statusLabel.textColor = UIColor(red: 205/255, green: 24/255, blue: 24/255, alpha: 1.0)
            }
        }
    }
    
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 24)
        label.textColor = UIColor(red: 20/255, green: 80/255, blue: 163/255, alpha: 1.0)
        label.text = "Label Title"
        return label
    }()
    
    private let statusLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 18)
        label.textColor = .black
        label.text = "Status: Incomplete"
        return label
    }()
    
    // Lifecycle
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?){
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        backgroundColor = UIColor(red: 185/255, green: 180/255, blue: 199/255, alpha: 1.0)
        addSubview(titleLabel)
        titleLabel.anchor(top: topAnchor, left: leftAnchor, paddingTop: 4, paddingLeft: 8 )
        addSubview(statusLabel)
        statusLabel.anchor(top: titleLabel.bottomAnchor, left: leftAnchor, paddingTop: 4, paddingLeft: 8)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    
    // Selectors
    
    // Helpers
}
