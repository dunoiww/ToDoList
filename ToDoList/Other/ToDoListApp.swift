//
//  ToDoListApp.swift
//  ToDoList
//
//  Created by Ngô Nam on 21/08/2023.
//

import FirebaseCore
import SwiftUI

@main
struct ToDoListApp: App {
    init() {
        FirebaseApp.configure()
    }
    
    var body: some Scene {
        WindowGroup {
            MainView()
        }
    }
}
