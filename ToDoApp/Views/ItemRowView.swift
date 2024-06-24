//
//  ItemRowView.swift
//  ToDoApp
//
//  Created by Anna Radoutska on 20.06.2024.
//

import SwiftUI

struct ItemRowView: View {
    @State var item: Item
    
    private let dateFormatter: DateFormatter = {
        var formatter = DateFormatter()
        formatter.locale = Locale(identifier: "en_US")
        return formatter
    }()
    
    private var dateDeadline: String {
        guard let date = item.deadline else { return "" }
        dateFormatter.setLocalizedDateFormatFromTemplate("dMMM")
        return dateFormatter.string(from: date)
    }
    
    private var fullDateDeadline: String {
        guard let date = item.deadline else { return "" }
        dateFormatter.timeStyle = .short
        return dateFormatter.string(from: date)
    }
    
    var body: some View {
        HStack(spacing: 20) {
            Text("\(dateDeadline)" )
                .foregroundStyle(.gray)
                .font(.system(size: 13))
                .fontWeight(.medium)
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 10) {
                    Text(item.title ?? "Untitled")
                        .font(.system(size: 15))
                        .fontWeight(.regular)
                    Text(fullDateDeadline)
                        .font(.system(size: 12))
                        .foregroundStyle(.gray)
                        .fontWeight(.light)
                }
                .padding(.vertical, 10)
                .padding(.horizontal, 15)
                Spacer()
                Text(item.itemGroup?.name ?? "")
                    .padding(.top, 10)
                    .font(.system(size: 12))
                    .foregroundStyle(.gray)
                    .padding(.trailing, 15)
            }
            .background(.white)
            .clipShape(RoundedRectangle(cornerRadius: 7))
            .shadow(color: .gray.opacity(0.5), radius: 5)
        }
    }
}

