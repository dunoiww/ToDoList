//
//  ProfileView.swift
//  ToDoList
//
//  Created by Ngô Nam on 25/08/2023.
//

import SwiftUI

struct ProfileView: View {
    @StateObject var viewModel = ProfileViewViewModel()
    var body: some View {
        NavigationView {
            VStack {
                if let user = viewModel.user {
                    profile(user: user)
                } else {
                    Text("Loading Profile...")
                }
            }
            .navigationTitle("Profile")
        }
        .onAppear {
            viewModel.fetchUser()
        }
        .fullScreenCover(
          isPresented: $viewModel.showingPreview,
          onDismiss: { viewModel.fetchUser() }
        ) {
          PreviewAvatarView()
        }
    }
    
    @ViewBuilder
    func profile(user: User) -> some View {
        //avatar
        
        Button {
            viewModel.showingPreview.toggle()
        } label: {
            if user.avatarURL != "" {
                AsyncImage(url: URL(string: user.avatarURL)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: 256, height: 256)
                        .cornerRadius(128)
                        .overlay(RoundedRectangle(cornerRadius: 128)
                            .stroke(Color.black, lineWidth: 3)
                        )
                } placeholder: {
                    ProgressView()
                }
            } else {
                Image(systemName: "person.circle")
                    .resizable()
                    .scaledToFit()
                    .foregroundColor(.blue)
                    .frame(width: 128, height: 128)
                    .padding()
            }
            
        }
        
        //info
        VStack(alignment: .leading) {
            HStack {
                Text("Name:")
                    .bold()
                Text(user.name)
            }
            .padding()
            
            HStack {
                Text("Email:")
                    .bold()
                Text(user.email)
            }
            .padding()
            
            HStack {
                Text("Member since:")
                    .bold()
                Text("\(Date(timeIntervalSince1970: user.joined).formatted(date: .abbreviated, time: .shortened))")
            }
            .padding()
        }
        .padding()
        
        Spacer()
        
        //button sign out
        Button("Log out") {
            viewModel.logOut()
        }
        .tint(.white)
        .padding()
        .frame(width: 300)
        .background(Color(hue: 1.0, saturation: 0.68, brightness: 0.981))
        .cornerRadius(16)
        
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
