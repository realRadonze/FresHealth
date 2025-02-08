import SwiftUI
import Combine
import UIKit

class LoginViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var loginSuccess: Bool = false
    @Published var showAlert: Bool = false

    func login() {
        // temporary logic
        if username == "user" && password == "password" {
            loginSuccess = true
        } else {
            loginSuccess = false
            showAlert = true
        }
    }
}

struct LoginView: View {
    @ObservedObject private var viewModel = LoginViewModel()
    @State private var isActive: Bool = false // State to control navigation

    var body: some View {
        NavigationView {
            VStack {
                
                Image(.fresHealthLogo)
                    .resizable()
                    .frame(maxWidth: 150, maxHeight: 150)
                    .cornerRadius(32)
                
                Text("FresHealth")
                    .font(.system(size: 60, weight: .bold))
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)

                TextField("username", text: $viewModel.username)
                    .font(.system(size: 24, weight: .medium))
                    .padding(.leading)
                    .frame(width: 320, height: 60)
                    .background(Color(white: 0.9))
                    .cornerRadius(16)
                    .shadow(color: .black.opacity(0.5), radius: 6, x: 0, y: 4)
                    .textFieldStyle(DefaultTextFieldStyle())
                            
                SecureField("password", text: $viewModel.password)
                    .font(.system(size: 24, weight: .medium))
                    .padding(.leading)
                    .frame(width: 320, height: 60)
                    .background(Color(white: 0.9))
                    .cornerRadius(16)
                    .shadow(color: .black.opacity(0.5), radius: 6, x: 0, y: 4)
                    .textFieldStyle(DefaultTextFieldStyle())
                
                Spacer()
                NavigationLink(destination: ContentView().navigationBarBackButtonHidden(true), isActive: $isActive) {
                    EmptyView()
                }

                Button(action: {
                    viewModel.login() // Call login function
                    if viewModel.loginSuccess {
                        isActive = true   // Navigate to ContentView
                    }
                }) {
                    Text("login")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: 320, minHeight: 60)
                        .background(.appGreen)
                        .cornerRadius(16)
                        .shadow(color: .black.opacity(0.5), radius: 6, x: 0, y: 4)
                }
                .alert(isPresented: $viewModel.showAlert) {
                    Alert(title: Text("Login Failed"), message: Text("Invalid username or password"), dismissButton: .default(Text("OK")))
                }

                NavigationLink(destination: RegisterView()) {
                    Text("register")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.black)
                        .frame(maxWidth: 320, minHeight: 60)
                        .background(.white)
                        .cornerRadius(16)
                        .shadow(color: .black.opacity(0.5), radius: 6, x: 0, y: 4)
                }
            }
            .padding()
            .background(LinearGradient(gradient: Gradient(colors: [Color.cyan, Color.green]), startPoint: .topLeading, endPoint: .bottomTrailing))
            .navigationBarBackButtonHidden(true) // Hide the back button
            
        }
    }
}

#Preview {
    LoginView()
}
