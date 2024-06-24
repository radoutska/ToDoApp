//
//  GroupInputForm.swift
//  ToDoApp
//
//  Created by Anna Radoutska on 21.06.2024.
//

import SwiftUI

struct GroupInputForm: View {
    @Environment(\.dismiss) var dismiss
    @State var viewModel: ViewModel
    
    @State private var title: String = ""
    @State private var selectedTasks: [Item] = []
    
    var body: some View {
        NavigationView {
            VStack(spacing: 10) {
                TextField("Enter group name",
                          text: $title)
                .padding(.top, 20)
                VStack {
                    ForEach(viewModel.tasks, id: \.id) { item in
                        let selected = item.itemGroup != nil
                        ItemRowListView(disabled: selected, item: item)
                            .onTapGesture {
                                selectTask(item: item)
                            }
                    }
                }
                
                Button {
                    viewModel.addGroup(title: title, tasks: selectedTasks)
                    dismiss()
                } label: {
                    Text("Save")
                        .frame(minWidth: 100, maxWidth: .infinity)
                        .foregroundStyle(.white)
                        .fontWeight(.heavy)
                        .padding(.vertical, 20)
                        .background(.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                .padding(.horizontal, 10)
            }
            .padding(30)
            .navigationTitle("Create new group")
            .navigationBarTitleDisplayMode(.inline)
        }
        .navigationViewStyle(StackNavigationViewStyle())
    }
    
    private func selectTask(item: Item) {
        viewModel.addTaskToSelected(item: item)
    }
}
//
//#Preview {
//    GroupInputForm(viewModel: ViewModel())
//}
