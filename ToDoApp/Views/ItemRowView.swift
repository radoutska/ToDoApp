//
//  ItemRowView.swift
//  ToDoApp
//
//  Created by Anna Radoutska on 20.06.2024.
//

import SwiftUI

struct ItemRowView: View {
    @State var item: Item
    @ObservedObject var viewModel: ViewModel
    @Binding var isEdited: Bool
    var showStatus: Bool = false
    @State private var isPresented: Bool = false
    
    var body: some View {
        ZStack(alignment:.topTrailing) {
            HStack(spacing: 20) {
                Text("\(viewModel.dateDeadline(for: item.deadline))" )
                    .foregroundStyle(.gray)
                    .font(.system(size: 13))
                    .fontWeight(.medium)
                HStack(alignment: .top) {
                    VStack(alignment: .leading, spacing: 10) {
                        Text(item.title)
                            .font(.system(size: 15))
                            .fontWeight(.regular)
                        Text(viewModel.fullDateDeadline(for: item.deadline))
                            .font(.system(size: 12))
                            .foregroundStyle(.gray)
                            .fontWeight(.light)
                    }
                    .padding(.vertical, 10)
                    .padding(.horizontal, 15)
                    Spacer()
                    if showStatus {
                        Text(item.status ?? "open")
                            .foregroundStyle(ToDoStatus(rawValue: item.status ?? "open")?.color ?? .gray)
                            .padding(.top, 10)
                            .font(.system(size: 12))
                            .foregroundStyle(.gray)
                            .padding(.trailing, 15)
                    }
                    else {
                        Text(item.itemGroup?.name ?? "")
                            .padding(.top, 10)
                            .font(.system(size: 12))
                            .foregroundStyle(.gray)
                            .padding(.trailing, 15)
                    }
                }
                .background(.white)
                .clipShape(RoundedRectangle(cornerRadius: 7))
                .shadow(color: .gray.opacity(0.5), radius: 5)
            }
            .padding(.vertical, 10)
            .onTapGesture {
                isPresented.toggle()
            }
            if $isEdited.wrappedValue {
                Button {
                    viewModel.deleteTask(item: item) { isSucceed in
                        if isSucceed {
                            
                        }
                        else {
                            // TODO: Handle error
                        }
                    }
                } label: {
                    Image(systemName: "minus.circle.fill")
                        .foregroundStyle(.red)
                        .shadow(radius: 5)
                }
                .transition(.slide)
            }
        }
        .sheet(isPresented: $isPresented) {
            InputForm(viewModel: viewModel, item: item)
        }
    }
}

