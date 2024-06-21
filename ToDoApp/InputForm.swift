//
//  InputForm.swift
//  ToDoApp
//
//  Created by Anna Radoutska on 01.06.2024.
//

import SwiftUI

enum InputFormType {
    case task
    case group
}

enum InputFormStatus {
    case create
    case edit
}

struct InputForm: View {
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: ViewModel
    
    @State var item: Item? {
        didSet {
            type = .task
            formStatus = .edit
            status = item?.status ?? "open"
        }
    }
    @State var group: Group? {
        didSet {
            formStatus = .edit
            type = .group
        }
    }
    
    @State var type: InputFormType? = .task
    @State private var formStatus: InputFormStatus = .create
    @State private var status: String = "open"
    @State private var title: String = ""
    @State private var deadline: Date = Date()
    
    var body: some View {
        VStack {
            Form {
                Section {
                    TextField(type == .task ?
                              "Enter task name" :
                                "Enter group name",
                              text: $title)
                } header: {
                    Text("Title")
                }
                .listRowBackground(Color.blue)
                Section {
                    DatePicker("Select a deadline", selection: $deadline, displayedComponents: .date)
                } header: {
                    Text("Date")
                }
                .listRowBackground(Color.blue)
                Section {
                    Picker("Status", selection: $status){
                        ForEach(ToDoStatus.allCases) { option in
                            Text(option.description)
                        }
                    }
                    .pickerStyle(SegmentedPickerStyle())
                } header: {
                    Text("Status")
                }
                .listRowBackground(Color.blue)
            }
            .tint(.pink)
            .scrollContentBackground(.hidden)
            Button {
                save()
            } label: {
                Text("Save")
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
        .padding(.top, 40)
    }
    
    private func save() {
        switch (type, formStatus) {
        case (.task, .create):
            viewModel.addTask(title: $title.wrappedValue, deadline: $deadline.wrappedValue, status: $status.wrappedValue)
        case (.group, .create):
            viewModel.addGroup(title: $title.wrappedValue)
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
        if let group = group {
            return group.name ?? "Untitled"
        }
        if type == .group {
            return "New group"
        }
        else {
            return "New item"
        }
    }
}

#Preview {
    InputForm(viewModel: ViewModel(), type: .group)
}
