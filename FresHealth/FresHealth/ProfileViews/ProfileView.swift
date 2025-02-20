//
//  Untitled.swift
//  FresHealth
//
//  Created by mac on 2025/2/15.
//

import SwiftUI

struct ProfileView: View {
    @StateObject private var viewModel = ProfileViewModel()

    var body: some View {
        VStack {
            // top bar
            ZStack {
                Color(white: 0.9)
                    .cornerRadius(4)
                    .frame(maxWidth: .infinity, maxHeight: 80)
                    .shadow(color: .black.opacity(0.5), radius: 6, x: 0, y: 4)
                VStack {
                    Text("FresHealth")
                        .font(.system(size: 28, weight:.medium))
                        .foregroundColor(Color.black)
                    Text("Profile")
                        .font(.system(size: 18, weight:.light))
                        .foregroundColor(.black)
                }
            }
            .padding(.horizontal)
            Spacer()
        
            VStack {
                if let avatar = viewModel.avatar {
                    Image(uiImage: avatar)
                        .resizable()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 4))
                        .shadow(radius: 10)
                        .padding()
                } else {
                    Image("default")
                        .resizable()
                        .frame(width: 100, height: 100)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 4))
                        .shadow(radius: 10)
                        .padding()
                }
                
                Text(viewModel.username)
                    .font(.title)
                Text("Weight: \(viewModel.weight) kg")
                Text("Height: \(viewModel.height) cm")
                Text("Expected Weight: \(viewModel.expectWeight) kg")
                
            }
            
            Spacer()
            
            Button(action: {
                viewModel.showAlert = true
            }) {
                Text("logout")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white)
                    .frame(maxWidth: 320, minHeight: 60)
                    .background(Color.appRed)
                    .cornerRadius(16)
                    .shadow(color: .black.opacity(0.5), radius: 6, x: 0, y: 4)
                    .padding(.bottom)
            }
            .alert(isPresented: $viewModel.showAlert) {
                Alert(
                    title: Text("warning"),
                    message: Text("logoutWarn"),
                    primaryButton: .destructive(Text("Yes")) {
                        viewModel.logout()
                    },
                    secondaryButton: .cancel(Text("No"))
                )
            }
        }
        .fullScreenCover(isPresented: $viewModel.isLoggedOut) {
            LoginView()
        }
    }
}

#Preview {
    ProfileView()
}
