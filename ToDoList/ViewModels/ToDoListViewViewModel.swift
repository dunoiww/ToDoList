//
//  ToDoListViewViewModel.swift
//  ToDoList
//
//  Created by Ngô Nam on 25/08/2023.
//

import FirebaseAuth
import FirebaseFirestore
import Foundation

class ToDoListViewViewModel: ObservableObject {
    @Published var showingNewItemView = false
    @Published var showingEditItemView = false
    @Published var itemId = ""
    private let userId: String
    
    init(userId: String) {
        self.userId = userId
    }
    
    /// Delete
    /// - Parameter id: item id to delete
    func delete(id: String) {
        
        let db = Firestore.firestore()
        
        db.collection("users")
            .document(userId)
            .collection("todos")
            .document(id)
            .delete()
    }
    
}
