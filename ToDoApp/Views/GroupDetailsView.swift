//
//  GroupDetailsView.swift
//  ToDoApp
//
//  Created by Anna Radoutska on 22.06.2024.
//

import SwiftUI

struct GroupDetailsView: View {
    @Environment(\.dismiss) var dismiss
    @State var group: Group
    @ObservedObject var viewModel: ViewModel
    
    var body: some View {
        NavigationView {
            VStack {
                Text("\(String(group.itemGroup?.count ?? 0)) items")
                VStack {
                    if let items = group.itemGroup as? Set<Item> {
                        ForEach(Array(items)) { item in
                            ItemRowView(item: item, viewModel: viewModel)
                                .padding([.vertical], 10)
                        }
                    } else {
                        Text("No items")
                    }
                }
                Spacer()
            }
            .padding(.horizontal, 10)
            .navigationTitle(group.name ?? "Untitled")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarRole(.navigationStack)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.backward")
                            .fontWeight(.light)
                            .foregroundStyle(.black)
                    }
                }
            }
        }
    }
}
