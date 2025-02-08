//
//  WaterView.swift
//  FresHealth
//
//  Created by mac on 2025/2/5.
//

import SwiftUI

struct WaterView: View {
    @Environment(\.presentationMode) var presentationMode // 获取呈现模式

    var body: some View {
        VStack {
            Text("You have drunk a cup of water!")
            
            Button(action: {
                presentationMode.wrappedValue.dismiss() // 返回上一个视图
            }) {
                Text("OK")
                    .foregroundColor(.white)
                    .frame(maxWidth: 80, minHeight: 50)
                    .background(Color.gray.opacity(0.9))
                    .cornerRadius(8)
                    .shadow(color: .black.opacity(0.4), radius: 10, x: 0, y: 4)
            }
            .padding()
        }
        .navigationBarBackButtonHidden(true) // Hide the back button here
    }
}
