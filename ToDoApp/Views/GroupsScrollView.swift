//
//  GroupsScrollView.swift
//  ToDoApp
//
//  Created by Anna Radoutska on 21.06.2024.
//

import SwiftUI

struct GroupsScrollView: View {
    @Binding var groups: [Group]
    
    var body: some View {
        ScrollView(.horizontal) {
            HStack {
                ForEach(groups, id: \.self) {
                    group in GroupView(group: group, completedPercent: 50)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .shadow(radius: 5)
                        .padding(5)
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
