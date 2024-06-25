//
//  GroupView.swift
//  ToDoApp
//
//  Created by Anna Radoutska on 05.06.2024.
//

import SwiftUI

struct GroupView: View {
    @Binding var group: Group
    
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
            ProgressView(String("\(group.percent)%"), value: Double(group.percent), total: 100)
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
