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
    @State private var isEdited: Bool = false
    @State private var sheetType: SheetType = .task
    @StateObject private var viewModel = ViewModel()
    
    var searchResults: [Item] {
        if searchText.isEmpty {
            return viewModel.tasks
        } else {
            return viewModel.tasks.filter {
                $0.title.contains(searchText) }
        }
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                ScrollView(.vertical) {
                    VStack(spacing: 5) {
                        HStack {
                            Text("Categories")
                                .fontWeight(.semibold)
                            Spacer()
                            Button {
                                isPresented.toggle()
                            } label: {
                                Image(systemName: "plus")
                            }
                            .tint(.gray)
                        }
                        GroupsScrollView(viewModel: viewModel)
                            .scrollIndicators(.hidden)
                        HStack {
                            Text("My open tasks")
                                .fontWeight(.semibold)
                            Spacer()
                            Button("Edit") {
                                isEdited.toggle()
                            }
                        }
                        .padding([.vertical], 15)
                        
                        VStack {
                            ForEach(searchResults, id: \.self) {
                                item in
                                ZStack {
                                    ItemRowView(item: item, viewModel: viewModel, isEdited: $isEdited)
                                }
                            }
                        }
                        .sheet(isPresented: $isPresented) {
                            GroupInputForm(viewModel: viewModel)
                        }
                    }
                    .searchable(text: $searchText)
                    .padding()
                }
                CustomTabBar(viewModel: viewModel)
            }
            .navigationTitle("Welcome back!")
            .navigationBarTitleDisplayMode(.inline)
        }
    }
}

#Preview {
    ContentView()
}
