//
//  ItemRowListView.swift
//  ToDoApp
//
//  Created by Anna Radoutska on 23.06.2024.
//

import SwiftUI

struct ItemRowListView: View {
    @Binding var isSelected: Bool
    var disabled: Bool {
        item.itemGroup != nil
    }
    
    let item: Item
    
    private var fullDateDeadline: String {
        ViewModel.dateFormatter.string(from: item.deadline ?? Date())
    }
    
    var body: some View {
        HStack {
            if disabled {
                Text(item.title ?? "Untitled")
                    .fontWeight(.light)
                Text(String(fullDateDeadline))
                    .font(.system(size: 12))
                    .foregroundStyle(.gray)
                    .fontWeight(.light)
            }
            else {
                Text(item.title ?? "Untitled")
                    .fontWeight(.light)
                Text(String(fullDateDeadline))
                    .font(.system(size: 12))
                    .foregroundStyle(.gray)
                    .fontWeight(.light)
            }
            Spacer()
            Image(systemName: "checkmark")
                .padding(.trailing, 5)
                .opacity($isSelected.wrappedValue ? 1 : 0)
        }
        .padding(10)
        .background(.babyBlue)
        .clipShape(RoundedRectangle(cornerRadius: 5))
    }
}
