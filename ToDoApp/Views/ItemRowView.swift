//
//  ItemRowView.swift
//  ToDoApp
//
//  Created by Anna Radoutska on 20.06.2024.
//

import SwiftUI

struct ItemRowView: View {
    @State var item: Item
    
    var body: some View {
        HStack(spacing: 20) {
            Text("12 PM")
                .foregroundStyle(.gray)
                .font(.system(size: 13))
                .fontWeight(.medium)
            HStack() {
                VStack(alignment: .leading, spacing: 10) {
                    Text(item.title ?? "Untitled")
                        .font(.system(size: 15))
                        .fontWeight(.regular)
                    Text(dateFormatting())
                        .font(.system(size: 12))
                        .foregroundStyle(.gray)
                        .fontWeight(.light)
                }
                .padding(.vertical, 10)
                .padding(.horizontal, 15)
                Spacer()
            }
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 7))
            .shadow(color: .gray.opacity(0.5), radius: 5)
        }
    }
    
    private func dateFormatting() -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateStyle = .short
        return dateFormatter.string(from: item.deadline ?? Date())
    }
}

#Preview {
    var item = Item()
    item.title = "Item"
    item.status = "blocked"
    item.id = UUID()
    return ItemRowView(item: item)
}

