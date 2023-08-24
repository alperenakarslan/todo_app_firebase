//
//  CreateTodoController.swift
//  todo_app_firebase
//
//  Created by Alperen Akarslan on 23.08.2023.
//

import UIKit

class CreateTodoController :  UIViewController{
    // Properties
    
    private let titleLabel: UILabel = {
        let label = UILabel()
        label.font = .systemFont(ofSize: 20)
        label.textColor = .black
        label.text = "Create a new TODO item"
        label.textAlignment = .center
        return label
    }()
    
    private let itemTextField: UITextField = {
        let tf = UITextField()
        tf.font = .systemFont(ofSize: 24)
        tf.textColor = .white
        tf.backgroundColor = .lightGray
        return tf
    }()
    
    private lazy var createButton: UIButton = {
        let button = UIButton()
        button.setTitle("Create title", for: .normal)
        button.setTitleColor(.black, for: .normal)
        button.titleLabel?.font = .boldSystemFont(ofSize: 24)
        button.backgroundColor = .systemGreen
        button.addTarget(self, action: #selector(createItemPressed), for: .touchUpInside)
        button.layer.cornerRadius = 10
        return button
        
    }()
    
    // LifeCycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureUI()
    }
    
    // Selectors
    
    @objc func createItemPressed(){
        guard let todoText = itemTextField.text else {return }
//        PostService.shared.uploadTodoItem(text: todoText
        PostService.shared.uploadTodoItem(text: todoText) { (err, ref) in
            self.itemTextField.text = ""
            self.dismiss(animated: true, completion: nil)
        }
    }
    
    // Helpers
    
    func configureUI(){
        // Title Label
        view.backgroundColor = .white
        view.addSubview(titleLabel)
        titleLabel.anchor(top: view.topAnchor, left: view.leftAnchor, right: view.rightAnchor, paddingTop: 16, paddingLeft: 16, paddingRight: 16)
        
        view.addSubview(itemTextField)
        itemTextField.anchor(top: titleLabel.bottomAnchor, left: titleLabel.leftAnchor, right: titleLabel.rightAnchor, paddingTop: 128, paddingLeft: 16, paddingRight: 16, height: 40)
        itemTextField.delegate = self
        
        // Button
        view.addSubview(createButton)
        createButton.anchor(left: view.leftAnchor, bottom: view.safeAreaLayoutGuide.bottomAnchor, right: view.rightAnchor, paddingLeft: 40, paddingBottom: 32, paddingRight: 40, height: 40)
    }
}

// UIExtension Delegate

extension CreateTodoController: UITextFieldDelegate{
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        return true
    }
}
