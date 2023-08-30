//
//  ToDoListItemView.swift
//  ToDoList
//
//  Created by Ngô Nam on 25/08/2023.
//

import SwiftUI

struct ToDoListItemView: View {
    @StateObject var viewModel = ToDoListItemViewViewModel()
    var item: ToDoListItem
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(item.title)
                    .font(.title)
                Text("\(Date(timeIntervalSince1970: item.dueDate).formatted(date: .abbreviated, time: .shortened))")
                    .font(.footnote)
                    .foregroundColor(.secondary)
            }
            
            Spacer()
            
            Image(systemName: item.isDone ? "checkmark.circle.fill" : "checkmark.circle")
                .font(.system(size: 25))
                .foregroundColor(.blue)
        }
        .onTapGesture {
            withAnimation(Animation.easeOut(duration: 0.5)) {
                viewModel.toggleIsDone(item: item)
            }
        }
    }
}

struct ToDoListItemView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoListItemView(item: .init(id: "123",
                                     title: "Get milk",
                                     dueDate: Date().timeIntervalSince1970,
                                     createdDate: Date().timeIntervalSince1970,
                                     isDone: false))
    }
}
