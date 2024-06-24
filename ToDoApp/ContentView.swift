//
//  ContentView.swift
//  ToDoApp
//
//  Created by Anna Radoutska on 01.06.2024.
//

import SwiftUI

struct ContentView: View {
    private enum SheetType {
        case task
        case group
        
        var id: Int {
            hashValue
        }
    }
    
    @State private var searchText = ""
    @State private var isPresented: Bool = false
    @State private var sheetType: SheetType = .task
    @StateObject private var viewModel = ViewModel()
    
    var body: some View {
        NavigationStack {
            ScrollView(.vertical) {
                VStack(spacing: 10) {
                    HStack {
                        Text("Categories")
                            .fontWeight(.semibold)
                        Spacer()
                        Button("View all") {
                            // TODO: Add view all
                        }
                        .tint(.gray)
                    }
                    GroupsScrollView(groups: $viewModel.groups)
                        .scrollIndicators(.hidden)
                        .searchable(text: $searchText)
                    HStack {
                        Text("My open tasks")
                            .fontWeight(.semibold)
                        Spacer()
                    }
                    .padding([.vertical], 15)
                    
                    VStack {
                        ForEach(viewModel.tasks, id: \.self) {
                            item in ItemRowView(item: item)
                                .padding([.vertical], 10)
                        }
                    }
                    
                    Button("Button") {
                        isPresented.toggle()
                        sheetType = .task
                        
                    }
                    Button("Group") {
                        sheetType = .group
                        isPresented.toggle()
                    }
                    .sheet(isPresented: $isPresented) {
                        switch $sheetType.wrappedValue {
                        case .task:
                            InputForm(viewModel: viewModel)
                        case .group:
                            GroupInputForm(viewModel: viewModel)
                        }
                    }
                }
                .padding()
            }
        }
    }
}

#Preview {
    ContentView()
}
