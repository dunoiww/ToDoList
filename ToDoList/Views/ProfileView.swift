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
    }
    
    @ViewBuilder
    func profile(user: User) -> some View {
        //avatar
        Image(systemName: "person.circle")
            .resizable()
            .scaledToFit()
            .foregroundColor(.blue)
            .frame(width: 125, height: 125)
            .padding()
        
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
        
        //button sign out
        Button("Log out") {
            viewModel.logOut()
        }
        .tint(.red)
        .padding()
        
        Spacer()
    }
}

struct ProfileView_Previews: PreviewProvider {
    static var previews: some View {
        ProfileView()
    }
}
