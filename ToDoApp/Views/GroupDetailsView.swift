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
                VStack {
                    if let items = group.itemGroup as? Set<Item> {
                        ForEach(Array(items)) { item in
                            ItemRowView(item: item, viewModel: viewModel, showStatus: true)
                                .padding([.vertical], 10)
                        }
                    } else {
                        // TODO:
                    }
                }
                Spacer()
            }
            .padding(.horizontal, 10)
            .navigationTitle("\(group.name ?? "Untitled") (\(group.itemGroup?.count ?? 0))")
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
