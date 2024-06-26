//
//  GroupInputForm.swift
//  ToDoApp
//
//  Created by Anna Radoutska on 21.06.2024.
//

import SwiftUI

struct GroupInputForm: View {
    @Environment(\.dismiss) var dismiss
    @StateObject var viewModel: ViewModel
    
    @State private var title: String = ""
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section {
                        TextField("Enter group name", text: $title)
                            .listRowBackground(Color("babyBlue"))
                    } header: {
                        Text("Title")
                            .textCase(nil)
                    }
                    
                    Section {
                        Text("Tasks in this group")
                            .fontWeight(.light)
                        ForEach(viewModel.tasks) { item in
                            ItemRowListView(isSelected: Binding<Bool>(
                                get: {
                                    viewModel.isSelected(item: item)
                                },
                                set: { _ in
                                    viewModel.toggleSelection(for: item)
                                }
                            ), item: item)
                            .onTapGesture {
                                viewModel.toggleSelection(for: item)
                            }
                        }
                        .listRowBackground(Color("babyBlue").opacity(0.3))
                        .listRowSeparator(.hidden)
                    }
                    .listRowInsets(EdgeInsets())

                }
                .scrollContentBackground(.hidden)
                
                Button {
                    viewModel.addGroup(title: title)
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
            .navigationTitle("Create new group")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "xmark")
                            .foregroundStyle(.black)
                            .font(.system(size: 12))
                    }
                }
            }
        }
    }
}

#Preview {
    GroupInputForm(viewModel: ViewModel())
}
