//
//  GroupsScrollView.swift
//  ToDoApp
//
//  Created by Anna Radoutska on 21.06.2024.
//

import SwiftUI

struct GroupsScrollView: View {
    @ObservedObject var viewModel: ViewModel
    @State private var selectedGroup: Group?
    @State private var isPresented: Bool = false
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach($viewModel.groups, id: \.self) {
                    group in GroupView(group: group)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .shadow(radius: 5)
                        .padding(5)
                        .padding(.vertical, 10)
                        .onTapGesture {
                            selectedGroup = group.wrappedValue
                            isPresented.toggle()
                        }
                        .sheet(item: $selectedGroup) { group in
                            GroupDetailsView(group: group, viewModel: viewModel)
                        }
                }
            }
        }
        .mask(
            HStack(spacing: 0) {
                
                LinearGradient(gradient:
                                Gradient(
                                    colors:
                                        [Color.black.opacity(0.2),
                                         Color.black]),
                               startPoint: .leading,
                               endPoint: .trailing
                )
                .frame(width: 80)
                
                Rectangle().fill(Color.black)
                
                LinearGradient(gradient:
                                Gradient(
                                    colors:
                                        [Color.black,
                                         Color.black.opacity(0.2)]),
                               startPoint: .leading,
                               endPoint: .trailing
                )
                .frame(width: 80)
            }
        )
    }
}

//#Preview {
//    GroupsScrollView(groups: [])
//}
