//
//  MainViewViewModel.swift
//  ToDoList
//
//  Created by Ngô Nam on 25/08/2023.
//

import FirebaseAuth
import Foundation

class MainViewViewModel: ObservableObject {
    @Published var currentUserId: String = ""
    private var handler: AuthStateDidChangeListenerHandle? //biến dùng để theo dõi sự thay đổi trạng thái xác thực người dùng
    
    init() {
        self.handler = Auth.auth().addStateDidChangeListener({ [weak self] _, user in
            DispatchQueue.main.async {
                self?.currentUserId = user?.uid ?? ""
            }
        })
        
        //khi người dùng đăng nhập thành công -> handler lắng nghe sự thay đổi -> sẽ thực hiện gán cho currentUserId = user.uid
    }
    
    public var isSignedIn: Bool {
        return Auth.auth().currentUser != nil
    }
}
