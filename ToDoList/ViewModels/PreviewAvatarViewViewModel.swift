//
//  PreviewAvatarViewViewModel.swift
//  ToDoList
//
//  Created by Ngô Nam on 10/09/2023.
//

import FirebaseAuth
import FirebaseStorage
import FirebaseFirestore
import Foundation
import SwiftUI

class PreviewAvatarViewViewModel: ObservableObject {
    init() {}
    
    @Published var showingPhotoLibrary = false
    @Published var image: UIImage?
    @Published var showingMessage = false
    @Published var message = ""
    
    func saveImage() {
        guard let userId = Auth.auth().currentUser?.uid else { return }
        
        guard let imageData = image?.jpegData(compressionQuality: 0.5) else { return }
        
        let storage = Storage.storage()
        let storageRef = storage.reference(withPath: userId)
        
        storageRef.putData(imageData, metadata: nil) { metadata, err in
            if let err = err {
                self.message = "Failed to upload your image."
                self.showingMessage = false
                print(err.localizedDescription)
                return
            }
            
            storageRef.downloadURL { url, err in
                if let err = err {
                    self.message = "Failed to retrieve from Storage."
                    self.showingMessage = false
                    print(err.localizedDescription)
                    return
                }
                
                self.message = "Photo uploaded successfully!"
                self.showingMessage = true
                
                let db = Firestore.firestore()
                db.collection("users")
                    .document(userId)
                    .updateData(["avatarURL": url?.absoluteString ?? ""]) { err in
                        if let err = err  {
                            print("Cannot update url of image \(err)")
                        }
                    }
            }
            
            
        }
    }
}
