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
        
    @State private var formStatus: InputFormStatus = .edit
    @State private var status: ToDoStatus = .open
    @State private var title: String = ""
    @State private var deadline: Date = Date()
    @State private var time: Date = Date()
    @State private var selectedGroup: String?
    
    var body: some View {
        NavigationView {
            VStack {
                Form {
                    Section {
                        TextField("Enter task name",
                                  text: $title).onAppear() {
                            self.title = item?.title ?? ""
                        }
                    } header: {
                        Text("Title")
                            .textCase(nil)
                    }
                    .listRowBackground(Color("babyBlue"))
                    Section {
                        DatePicker("Select a deadline", selection: $deadline)
                            .onAppear() {
                                self.deadline = item?.deadline ?? Date.now
                            }
                    } header: {
                        Text("Date")
                            .textCase(nil)
                    }
                    .tint(.black)
                    .listRowBackground(Color("babyBlue"))
                    Section {
                        Picker("Status", selection: $status){
                            ForEach(ToDoStatus.allCases) { option in
                                Text(option.description)
                                    .tag(option.id)
                            }
                        }
                        .onAppear() {
                            self.status = ToDoStatus(rawValue: item?.status ?? "Open") ?? ToDoStatus.open
                            self.selectedGroup = item?.itemGroup?.name
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        .background(.blue.opacity(0.5))
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
                                    Text(group.name ?? "")
                                        .tag(group.name)
                                }
                            }
                        }
                        .listRowBackground(Color("babyBlue"))
                        .tint(.black)
                    }
                }
                .scrollDisabled(true)
                .scrollContentBackground(.hidden)
                Button {
                    save()
                } label: {
                    // TODO: Fix this
                    Text(formStatus == .edit ? "Update" : "Save")
                        .frame(minWidth: 100, maxWidth: .infinity)
                        .foregroundStyle(.white)
                        .fontWeight(.heavy)
                        .padding(.vertical, 20)
                        .background(.blue)
                        .clipShape(RoundedRectangle(cornerRadius: 8))
                }
                .padding(.horizontal, 5)
                Spacer()
            }
            .navigationTitle(formStatus == .create ? "New task" : "Update task")
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
        .onAppear {
            self.formStatus = item != nil ? InputFormStatus.edit : InputFormStatus.create
        }
    }
    
    private func save() {
        switch formStatus {
        case .create:
            if title.isEmpty { title = "Untitled" }
            viewModel.addTask(title: $title.wrappedValue, deadline: $deadline.wrappedValue, status: $status.wrappedValue.description, group: $selectedGroup.wrappedValue)
        case .edit:
            guard let id = item?.id else { return }
            viewModel.editTask(id: id, title: $title.wrappedValue, deadline: $deadline.wrappedValue, status: $status.wrappedValue.description, group: $selectedGroup.wrappedValue)
        }
        dismiss()
    }
    
    private func configureTitle() -> String {
        if let item = item {
            return item.title
        }
        else {
            return "New item"
        }
    }
}

#Preview {
    InputForm(viewModel: ViewModel())
}
