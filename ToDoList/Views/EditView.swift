//
//  EditView.swift
//  ToDoList
//
//  Created by Ngô Nam on 30/08/2023.
//

import SwiftUI

struct EditView: View {
    @StateObject var viewModel = EditViewViewModel()
    @State var itemId: String
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        VStack {
            //title
            Text("Edit view")
                .font(.system(size: 50))
                .bold()
            
            //form
            
            Form {
                TextField("Title", text: $viewModel.title)
                    .autocorrectionDisabled()
                DatePicker("Due date", selection: $viewModel.dueDate)
                    .datePickerStyle(GraphicalDatePickerStyle())
                
                TLButton(title: "Save", background: .pink) {
                    if viewModel.canSave {
                        viewModel.save()
                        dismiss()
                    } else {
                        viewModel.showAlert = true
                    }
                }
                .padding()
            }
        }
        .onAppear {
            viewModel.id = itemId
            viewModel.fetchItem()
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text("Error"), message: Text("Please fill in all fields and select due date"))
        }
    }
}

struct EditView_Previews: PreviewProvider {
    static var previews: some View {
        EditView(itemId: "")
    }
}
