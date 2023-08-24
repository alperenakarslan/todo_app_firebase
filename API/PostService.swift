//
//  PostService.swift
//  todo_app_firebase
//
//  Created by Alperen Akarslan on 23.08.2023.
//

import UIKit
import Firebase

// items

struct TodoItem {
    var title: String
    var isComplete: Bool
    var id: String
    
    init(keyID: String, dictionary: [String: Any]) {
        self.title = dictionary["title"] as? String ?? ""
        self.isComplete = dictionary["isComplete"] as? Bool ?? false
        self.id = dictionary["id"] as? String ?? ""
    }
}



struct PostService {
    static let shared = PostService()
    let DB_REF = Database.database().reference()
    
    func fetchAllItems(completion: @escaping([TodoItem]) -> Void){
        
        var allItems = [TodoItem]()
        
        DB_REF.child("items").observe(.childAdded) { (snapshot) in
            fetchSingleItem(id: snapshot.key) { (item) in
                allItems.append(item)
                completion(allItems)
            }
        }
    }
    
    func fetchSingleItem(id: String, completion: @escaping(TodoItem) -> Void) {
        DB_REF.child("items").child(id).observeSingleEvent(of: .value) { (snapshot)  in
            guard let dictionary = snapshot.value as? [String: Any] else { return }
            let todoItem = TodoItem(keyID: id, dictionary: dictionary)
            completion(todoItem)
        }
    }
    
    func uploadTodoItem(text: String, completion: @escaping(Error?, DatabaseReference) -> Void){
        
        let values = ["title": text, "isComplete": false] as [String: Any]
        let id = DB_REF.child("items").childByAutoId()
        
        id.updateChildValues(values, withCompletionBlock: completion)
        id.updateChildValues(values) { (err, ref) in
            let value = ["id": id.key!]
            DB_REF.child("items").child(id.key!).updateChildValues(value, withCompletionBlock: completion)
        }
    }
    
    func updateItemStatus(todoId: String, isComplete: Bool, completion: @escaping(Error?, DatabaseReference) -> Void ){
        
        let value = ["isComplete": isComplete]
        DB_REF.child("items").child(todoId).updateChildValues(value, withCompletionBlock: completion)
    }
}
