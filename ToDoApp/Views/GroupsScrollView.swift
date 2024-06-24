//
//  GroupsScrollView.swift
//  ToDoApp
//
//  Created by Anna Radoutska on 21.06.2024.
//

import SwiftUI

struct GroupsScrollView: View {
    @Binding var groups: [Group]
    @State private var selectedGroup: Group?

    @State private var isPresented: Bool = false
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(groups, id: \.self) {
                    group in GroupView(group: group, completedPercent: group.percent)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .shadow(radius: 5)
                        .padding(5)
                        .onTapGesture {
                            selectedGroup = group
                            isPresented.toggle()
                        }
                        .sheet(item: $selectedGroup) { group in
                            GroupDetailsView(group: group)
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
