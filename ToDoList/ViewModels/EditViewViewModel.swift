//
//  EditViewViewModel.swift
//  ToDoList
//
//  Created by Ngô Nam on 30/08/2023.
//

import FirebaseAuth
import FirebaseFirestore
import Foundation

class EditViewViewModel: ObservableObject {
    
    init() {}
    
    @Published var todo: ToDoListItem? = nil
    @Published var id = ""
    @Published var title = ""
    @Published var dueDate = Date()
    @Published var showAlert = false
    
    func fetchItem() {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        let db = Firestore.firestore()
        db.collection("users")
            .document(userId)
            .collection("todos")
            .document(id)
            .getDocument { [weak self] snapshot, error in
                guard let data = snapshot?.data(), error == nil else { return }
                
                DispatchQueue.main.async {
                    let fetchedTodo = ToDoListItem(id: data["id"] as? String ?? "",
                                              title: data["title"] as? String ?? "",
                                              dueDate: data["dueDate"] as? TimeInterval ?? 0,
                                              createdDate: data["createdDate"] as? TimeInterval ?? 0,
                                              isDone: data["isDone"] as? Bool ?? false)
                    
                    self?.todo = fetchedTodo
                                    
                    // Sử dụng fetchedTodo để cập nhật các giá trị khác
                    self?.title = fetchedTodo.title
                    self?.dueDate = Date(timeIntervalSince1970: fetchedTodo.dueDate)
                }
            }
    }
    
    func save() {
        guard canSave else { return }

        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        let editItem = ToDoListItem(id: id,
                                   title: title,
                                   dueDate: dueDate.timeIntervalSince1970,
                                   createdDate: Date().timeIntervalSince1970,
                                   isDone: false)
        
        let db = Firestore.firestore()
        db.collection("users")
            .document(userId)
            .collection("todos")
            .document(id)
            .setData(editItem.asDictionary())
    }
    
    var canSave: Bool {
        guard !title.trimmingCharacters(in: .whitespaces).isEmpty else { return false }
        
        guard dueDate >= Date().addingTimeInterval(-86400) else {
            return false
        }
        
        return true
    }
}
