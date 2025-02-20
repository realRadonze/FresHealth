import SwiftUI

struct LoginView: View {
    @StateObject private var loginViewModel = LoginViewModel()
    @State private var isActive: Bool = false // State to control navigation

    var body: some View {
        NavigationView {
            VStack {
                
                Image("fresHealthLogo")
                    .resizable()
                    .frame(maxWidth: 150, maxHeight: 150)
                    .cornerRadius(32)
                
                Text("FresHealth")
                    .font(.system(size: 60, weight: .bold))
                    .frame(maxWidth: .infinity)
                    .foregroundColor(.white)

                TextField("username", text: $loginViewModel.username)
                    .autocapitalization(.none)
                    .font(.system(size: 24, weight: .medium))
                    .padding(.leading)
                    .frame(width: 320, height: 60)
                    .background(Color(white: 0.9))
                    .cornerRadius(16)
                    .shadow(color: .black.opacity(0.5), radius: 6, x: 0, y: 4)
                    .textFieldStyle(DefaultTextFieldStyle())
                            
                SecureField("password", text: $loginViewModel.password)
                    .font(.system(size: 24, weight: .medium))
                    .padding(.leading)
                    .frame(width: 320, height: 60)
                    .background(Color(white: 0.9))
                    .cornerRadius(16)
                    .shadow(color: .black.opacity(0.5), radius: 6, x: 0, y: 4)
                    .textFieldStyle(DefaultTextFieldStyle())
                
                Spacer()
                Button(action: {
                    loginViewModel.login { success in
                        if success {
                            isActive = true
                        }
                    }
                }) {
                    Text("login")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: 320, minHeight: 60)
                        .background(Color.appGreen)
                        .cornerRadius(16)
                        .shadow(color: .black.opacity(0.5), radius: 6, x: 0, y: 4)
                        .padding(.bottom)
                }
                .alert(isPresented: $loginViewModel.showAlert) {
                    Alert(title: Text("Login Failed"), message: Text(loginViewModel.alertMessage), dismissButton: .default(Text("OK")))
                }
                
                NavigationLink(destination: ContentView().navigationBarBackButtonHidden(true), isActive: $isActive) {
                    EmptyView()
                }
                
                NavigationLink(destination: RegisterView()) {
                    Text("register")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.black)
                        .frame(maxWidth: 320, minHeight: 60)
                        .background(Color.white)
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
        .environmentObject(LoginViewModel())
}
