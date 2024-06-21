//
//  GroupView.swift
//  ToDoApp
//
//  Created by Anna Radoutska on 05.06.2024.
//

import SwiftUI

struct GroupView: View {
    @State var group: Group
    @State var completedPercent: Int
    
    init(group: Group, completedPercent: Int) {
        self.group = group
        self.completedPercent = completedPercent
    }
    
    var body: some View {
        VStack {
            ZStack(alignment: .leading) {
                LinearGradient(gradient: Gradient(colors: [.blue, .green]), startPoint: .leading, endPoint: .trailing)
                VStack(alignment: .leading) {
                    Spacer()
                    Text(group.name ?? "Untitled")
                        .foregroundStyle(.white)
                        .fontWeight(.medium)
                    Text(String(group.itemGroup?.count ?? 0))
                        .foregroundStyle(.white)
                        .fontWeight(.thin)
                }
                .padding(.leading, 15)
                .padding(.bottom, 10)
                .padding(.top, 25)
            }
            ProgressView("50%", value: 50, total: 100)
                .font(.system(size: 14))
                .fontWeight(.bold)
                .padding([.bottom], 15)
                .padding([.leading,.trailing], 10)
            Spacer()
        }
        .frame(width: 180, height: 140)
        .background(.white)
    }
}

//struct GroupView_Previews: PreviewProvider {
//    static var previews: some View {
//        GroupView()
//    }
//}