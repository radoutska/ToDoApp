//
//  InputForm.swift
//  ToDoApp
//
//  Created by Anna Radoutska on 01.06.2024.
//

import SwiftUI

enum InputFormStatus {
    case create
    case edit
}

struct InputForm: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: ViewModel
    
    @State var item: Item? {
        didSet {
            formStatus = .edit
        }
    }
    
    @State var group: Group?
    
    @State private var formStatus: InputFormStatus = .create
    @State private var status: ToDoStatus = .open
    @State private var title: String = ""
    @State private var deadline: Date = Date()
    @State private var time: Date = Date()
    @State private var selectedGroup: String?
    
    @State private var showingAlert = false
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section {
                        TextField("Enter task name",
                                  text: $title)
                    } header: {
                        Text("Title")
                            .textCase(nil)
                    }
                    .listRowBackground(Color("babyBlue"))
                    Section {
                        DatePicker("Select a deadline", selection: $deadline)
                    } header: {
                        Text("Date")
                            .textCase(nil)
                    }
                    .listRowBackground(Color("babyBlue"))
                    Section {
                        Picker("Status", selection: $status){
                            ForEach(ToDoStatus.allCases) { option in
                                Text(option.description)
                                    .tag(option)
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .background(.blue)
                        .cornerRadius(8)
                        .padding(5)
                    } header: {
                        Text("Status")
                            .textCase(nil)
                    }
                    .listRowSeparatorTint(.red)
                    .listRowBackground(Color("babyBlue"))
                    if !viewModel.groups.isEmpty {
                        Section {
                            Picker("Group", selection: $selectedGroup) {
                                ForEach(viewModel.groups) { group in
                                    Text(group.name ?? "Untitled")
                                        .tag(group.name)
                                }
                            }
                        }
                    }
                }
                .scrollContentBackground(.hidden)
                Button {
                    if title.isEmpty {
                        showingAlert.toggle()
                    }
                    else {
                        save()
                    }
                } label: {
                    Text("Save")
                        .frame(minWidth: 100, maxWidth: .infinity)
                        .foregroundStyle(.white)
                        .fontWeight(.heavy)
                        .padding(.vertical, 20)
                        .background(.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                .alert("Please enter title", isPresented: $showingAlert) {
                            Button("Sure!", role: .cancel) { }
                        }
                .padding(.horizontal, 5)
                Spacer()
            }
            .navigationTitle("New task")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Text("gkkg")
                    }

                }
            }
        }
    }
    
    private func save() {
        switch formStatus {
        case .create:
            viewModel.addTask(title: $title.wrappedValue, deadline: $deadline.wrappedValue, status: $status.wrappedValue.description, group: $selectedGroup.wrappedValue)
        default:
            break
            // TODO: Something
        }
        dismiss()
    }
    
    private func configureTitle() -> String {
        if let item = item {
            return item.title ?? "Untitled"
        }
        else {
            return "New item"
        }
    }
}

#Preview {
    InputForm(viewModel: ViewModel())
}
