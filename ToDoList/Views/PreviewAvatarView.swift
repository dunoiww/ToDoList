//
//  PreviewAvatarvView.swift
//  ToDoList
//
//  Created by Ngô Nam on 10/09/2023.
//

import SwiftUI

struct PreviewAvatarView: View {
    @StateObject var viewModel = PreviewAvatarViewViewModel()
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            Button {
                viewModel.showingPhotoLibrary.toggle()
            } label: {
                if let image = viewModel.image {
                    Image(uiImage: image)
                        .resizable()
                        .scaledToFill()
                        .frame(width: 256, height: 256)
                        .cornerRadius(128)
                        .overlay(RoundedRectangle(cornerRadius: 128)
                            .stroke(Color.black, lineWidth: 3)
                        )
                } else {
                    Image(systemName: "person.circle")
                        .resizable()
                        .scaledToFit()
                        .foregroundColor(.black)
                        .frame(width: 256, height: 256)
                        .padding()
                }
            }
            
            Spacer()
                .frame(height: 50)
            
            HStack {
                Button("Save change") {
                    viewModel.saveImage()
                }
                .padding()
                .foregroundColor(.white)
                .frame(width: 150)
                .background(.blue)
                .cornerRadius(16)
                
                Button("Discard") {
                    dismiss()
                }
                .padding()
                .foregroundColor(.white)
                .frame(width: 150)
                .background(.red)
                .cornerRadius(16)
            }
        }
        .alert("Notify!", isPresented: $viewModel.showingMessage) {
            Button("OK", role: .cancel) {
                dismiss()
            }
        } message: {
            Text(viewModel.message)
        }
        .fullScreenCover(isPresented: $viewModel.showingPhotoLibrary) {
            ImagePicker(image: $viewModel.image)
        }
    }
}

struct PreviewAvatarView_Previews: PreviewProvider {
    static var previews: some View {
        PreviewAvatarView()
    }
}
