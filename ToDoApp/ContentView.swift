//
//  ContentView.swift
//  ToDoApp
//
//  Created by Anna Radoutska on 01.06.2024.
//

import SwiftUI

struct ContentView: View {
    @State private var searchText = ""
    @State private var isPresented: Bool = false
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
                        Text("My tasks")
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
                    }
                    .sheet(isPresented: $isPresented) {
                        InputForm(viewModel: viewModel)
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
