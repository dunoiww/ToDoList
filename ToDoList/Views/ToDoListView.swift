//
//  ToDoListItemsView.swift
//  ToDoList
//
//  Created by Ngô Nam on 25/08/2023.
//

import FirebaseFirestoreSwift
import SwiftUI

struct ToDoListView: View {
    @StateObject var viewModel: ToDoListViewViewModel
    @FirestoreQuery var items: [ToDoListItem]

    
    init(userId: String) {
        self._items = FirestoreQuery(collectionPath: "users/\(userId)/todos")
        //custom property wrapper vì _items chính là property wrapper
        //custom sử dụng tham số userId để thay đổi toàn bộ yêu cầu tìm nạp
        //Nếu để nguyên @FirestoryQuery thì vẫn được nhưng ở đây chúng ta muốn nó tìm theo tham số userId được truyền vào nên phải thay đổi property wrapper
        
        self._viewModel = StateObject(wrappedValue: ToDoListViewViewModel(userId: userId))
    }
    
    var body: some View {
        NavigationView {
            VStack {
                List(items) { item in
                    ToDoListItemView(item: item)
                        .swipeActions {
                            Button {
                                viewModel.delete(id: item.id)
                            } label: {
                                Image(systemName: "trash")
                            }
                            .tint(.red)
                        }
                    
                        .swipeActions(edge: .leading) {
                            Button {
                                viewModel.itemId = item.id
                                viewModel.showingEditItemView = true
                            } label: {
                                Image(systemName: "pencil")
                            }
                            .tint(.green)
                        }
                }
                .listStyle(PlainListStyle())
            }
            .navigationTitle("To Do List")
            .toolbar {
                Button {
                    viewModel.showingNewItemView = true
                } label: {
                    Image(systemName: "plus")
                }
            }
            .sheet(isPresented: $viewModel.showingNewItemView) {
                NewItemView()
            }
            .sheet(isPresented: $viewModel.showingEditItemView) {
                EditView(itemId: viewModel.itemId)
            }
        }
    }
}

struct ToDoListView_Previews: PreviewProvider {
    static var previews: some View {
        ToDoListView(userId: "El59Lex9XXRgegVRNJFc0hkDfDX2")
    }
}
