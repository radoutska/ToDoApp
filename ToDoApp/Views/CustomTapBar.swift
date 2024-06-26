//
//  CustomTapBar.swift
//  ToDoApp
//
//  Created by Anna Radoutska on 26.06.2024.
//

import SwiftUI

struct CustomTabBar: View {
    @ObservedObject var viewModel: ViewModel
    @State private var isPresented: Bool = false
    
    var body: some View {
        ZStack(alignment: .bottom) {
            VStack {
                Spacer()
                Rectangle()
                    .fill(Color.white)
                    .blur(radius: 20)
                    .frame(height: 50)
            }
            VStack {
                Spacer()
                TabBarShape()
                    .fill(Color.babyBlue)
                    .frame(height: 50)
            }
            Button {
                isPresented.toggle()
            } label: {
                Circle()
                    .fill(LinearGradient(
                        gradient: Gradient(colors: [.blue, .green]),
                        startPoint: .leading,
                        endPoint: .trailing))
                    .frame(width: 50, height: 50)
                    .shadow(radius: 3)
                    .overlay(
                        Image(systemName: "plus")
                            .foregroundColor(.white)
                            .font(.system(size: 24))
                    )
                    .offset(y: -25)
            }
            .sheet(isPresented: $isPresented) {
                InputForm(viewModel: viewModel)
            }
        }
        .edgesIgnoringSafeArea(.bottom)
    }
}

#Preview {
    CustomTabBar(viewModel: ViewModel())
}
