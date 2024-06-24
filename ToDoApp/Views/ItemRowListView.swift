//
//  ItemRowListView.swift
//  ToDoApp
//
//  Created by Anna Radoutska on 23.06.2024.
//

import SwiftUI

struct ItemRowListView: View {
    @State var selected: Bool = false
    @State var disabled: Bool
    
    let item: Item
    
    private let dateFormatter: DateFormatter = {
        var formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        return formatter
    }()
    
    private var fullDateDeadline: String {
        guard let date = item.deadline else { return "" }
        dateFormatter.dateStyle = .medium
        return dateFormatter.string(from: date)
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
            if selected {
                Image(systemName: "checkmark")
                    .padding(.trailing, 5)
            }
        }
        .padding(10)
        .background(.babyBlue)
        .clipShape(RoundedRectangle(cornerRadius: 5))
        .onTapGesture {
            selected.toggle()
        }
    }
}
