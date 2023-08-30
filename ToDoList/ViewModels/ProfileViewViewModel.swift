//
//  ProfileViewViewModel.swift
//  ToDoList
//
//  Created by Ngô Nam on 25/08/2023.
//

import FirebaseAuth
import FirebaseFirestore
import Foundation

class ProfileViewViewModel: ObservableObject {
    init() {}
    
    @Published var user: User? = nil
    
    func fetchUser() {
        guard let userId = Auth.auth().currentUser?.uid else {
            return
        }
        
        let db = Firestore.firestore()
        
            db.collection("users")
                .document(userId)
                .getDocument { [weak self] snapshot, error in
                    guard let data = snapshot?.data(), error == nil else {
                        return
                    }
                
                DispatchQueue.main.async {
                    self?.user = User(id: data["id"] as? String ?? "",
                                      name: data["name"] as? String ?? "",
                                      email: data["email"] as? String ?? "",
                                      joined: data["joined"] as? TimeInterval ?? 0)
                }
                //sử dụng DispatchQueue.main.async chỗ này đảm bảo rằng việc tải dữ liệu từ db sẽ không cản trở luồng làm việc hiện tại, luồng hiện tại có thể tiếp tục công việc trong khi chờ user được tải dữ liệu từ db
            }
    }
    
    func logOut() {
        do {
            try Auth.auth().signOut()
        } catch {
            print(error.localizedDescription)
        }
    }
}
