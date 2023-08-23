//
//  TodoCell.swift
//  todo_app_firebase
//
//  Created by Alperen Akarslan on 23.08.2023.
//

import UIKit

class TodoCell: UITableViewCell {
    
    // Properties
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .boldSystemFont(ofSize: 24)
        label.textColor = .black
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
        backgroundColor = .white
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
