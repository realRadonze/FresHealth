//
//  RegisterView.swift
//  FresHealth
//
//  Created by mac on 2025/2/5.
//

import SwiftUI

struct RegisterView: View {
    @ObservedObject private var viewModel = RegisterViewModel()
    @State private var isActive: Bool = false // State to control navigation
    @Environment(\.presentationMode) var presentationMode // 用于返回视图
    @State private var currentStep: Int = 1 // 控制当前步骤

    var body: some View {
        VStack {
            if currentStep == 1 {
                infoView
            } else if currentStep == 2 {
                passwordView
            } else if currentStep == 3 {
                weightView
            } else if currentStep == 4 {
                thankView
            }
        }
        .background(LinearGradient(gradient: Gradient(colors: [Color.cyan, Color.green]), startPoint: .topLeading, endPoint: .bottomTrailing))
        .navigationBarBackButtonHidden(true)
    }
    
    // User Basic Info Page
    var infoView: some View {
        VStack {
            HStack(alignment: .top) {
                Button(action: {
                    presentationMode.wrappedValue.dismiss() // 返回上一个视图
                }) {
                    Image(systemName: "arrow.left") // 使用系统的左箭头图标
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black)
                        .clipShape(Circle()) // 圆形背景
                }
                .padding(.leading) // 添加左侧填充
                Spacer() // 推动按钮到左边
            }
            Spacer()
            Text("Welcome!")
                .font(.system(size: 60, weight: .bold))
                .foregroundColor(.white)
            Text("Choose your avatar")
                .font(.system(size: 24, weight: .medium))
                .foregroundColor(.white)
            Text("and type your name")
                .font(.system(size: 24, weight: .medium))
                .foregroundColor(.white)
            
            Image(systemName: "person.crop.circle.fill") // 用户头像
                .resizable()
                .frame(width: 180, height: 180)
                .foregroundColor(.white)
                .padding(.trailing)
            Spacer()
            
            TextField("username", text: $viewModel.username)
                        .font(.system(size: 24, weight: .medium))
                        .padding(.leading)
                        .frame(width: 320, height: 60)
                        .background(Color(white: 0.9))
                        .cornerRadius(16)
                        .shadow(color: .black.opacity(0.5), radius: 6, x: 0, y: 4)
                        .textFieldStyle(DefaultTextFieldStyle())
                        .onChange(of: viewModel.username) { _ in
                            viewModel.validateUsername()
                        }

                    if !viewModel.isUsernameValid && !viewModel.username.isEmpty {
                        Text("用户名不能为空")
                            .foregroundColor(.red)
                            .font(.system(size: 20, weight: .bold))
                    }
            
            TextField("email", text: $viewModel.email)
                .font(.system(size: 24, weight: .medium))
                .padding(.leading)
                .frame(width: 320, height: 60)
                .background(Color(white: 0.9))
                .cornerRadius(16)
                .shadow(color: .black.opacity(0.5), radius: 6, x: 0, y: 4)
                .textFieldStyle(DefaultTextFieldStyle())
                .onChange(of: viewModel.email) { _ in
                    viewModel.validateEmail()
                }
            Spacer()
            
            if !viewModel.isEmailValid && !viewModel.email.isEmpty {
                Text("Unavailable Email")
                    .foregroundColor(.red)
                    .font(.system(size: 32, weight: .bold))
            }
            
            Button(action: {
                        if viewModel.isUsernameValid && viewModel.isEmailValid {
                            currentStep = 2 // 跳转到密码页面
                        }
                    }) {
                        Text("下一步")
                            .font(.system(size: 24, weight: .bold))
                            .foregroundColor(.white)
                            .frame(maxWidth: 320, minHeight: 60)
                            .background(viewModel.isUsernameValid && viewModel.isEmailValid ? .appGreen : Color.gray)
                            .cornerRadius(16)
                            .shadow(color: .black.opacity(0.5), radius: 6, x: 0, y: 4)
                    }
                    .disabled(!viewModel.isUsernameValid || !viewModel.isEmailValid)
            Spacer()
        }
    }
    
    // Password
    var passwordView: some View {
        VStack {
            HStack(alignment: .top) {
                Button(action: {
                    currentStep = 1 // 返回上一步
                }) {
                    Image(systemName: "arrow.left") // 使用系统的左箭头图标
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.black)
                        .clipShape(Circle()) // 圆形背景
                }
                .padding(.leading) // 添加左侧填充
                Spacer() // 推动按钮到左边
            }
            Spacer()
            Text("password")
                .font(.system(size: 60, weight: .bold))
                .foregroundColor(.white)
            Text("pwtip1")
                .font(.system(size: 24, weight: .medium))
                .foregroundColor(.white)
            Text("pwtip2")
                .font(.system(size: 24, weight: .medium))
                .foregroundColor(.white)
            Text("pwtip3")
                .font(.system(size: 24, weight: .medium))
                .foregroundColor(.appRed)
            Spacer()
            
            SecureField("password", text: $viewModel.password)
                .font(.system(size: 24, weight: .medium))
                .padding(.leading)
                .frame(width: 320, height: 60)
                .background(Color(white: 0.9))
                .cornerRadius(16)
                .shadow(color: .black.opacity(0.5), radius: 6, x: 0, y: 4)
                .textFieldStyle(DefaultTextFieldStyle())
            
            SecureField("password2", text: $viewModel.confirmPassword)
                .font(.system(size: 24, weight: .medium))
                .padding(.leading)
                .frame(width: 320, height: 60)
                .background(Color(white: 0.9))
                .cornerRadius(16)
                .shadow(color: .black.opacity(0.5), radius: 6, x: 0, y: 4)
                .textFieldStyle(DefaultTextFieldStyle())
                .onChange(of: viewModel.confirmPassword) { _ in
                    viewModel.validatePassword()
                }
            
            if !viewModel.isPasswordValid && !viewModel.confirmPassword.isEmpty {
                Text("密码不一致或格式不正确")
                    .foregroundColor(.red)
                    .font(.system(size: 32, weight: .bold))
            }

            Button(action: {
                if viewModel.isPasswordValid {
                    currentStep = 3 // Redirect to Weight Page
                    viewModel.register() // 调用注册函数
                }
            }) {
                Text("完成注册")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white)
                    .frame(maxWidth: 320, minHeight: 60)
                    .background(viewModel.isPasswordValid ? .appGreen : Color.gray)
                    .cornerRadius(16)
                    .shadow(color: .black.opacity(0.5), radius: 6, x: 0, y: 4)
            }
            .disabled(!viewModel.isPasswordValid)
            Spacer()
        }
    }
    
    // User Weight Information
    var weightView: some View {
        VStack {

            Spacer()
            Text("Weight")
                .font(.system(size: 60, weight: .bold))
                .frame(maxWidth: .infinity)
                .foregroundColor(.white)
            Text("Input your heights, weights")
                .font(.system(size: 24, weight: .medium))
                .foregroundColor(.white)
            Text("and your expected values.")
                .font(.system(size: 24, weight: .medium))
                .foregroundColor(.white)
            Text("You can modify it on Settings.")
                .font(.system(size: 24, weight: .medium))
                .foregroundColor(.white)
            
            Spacer()
            // Height Input
                Text("Height (cm)")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(.white)
                TextField("Height (cm)", value: $viewModel.height, formatter: NumberFormatter())
                    .font(.system(size: 24, weight: .medium))
                    .padding(.leading)
                    .frame(width: 320, height: 60)
                    .background(Color(white: 0.9))
                    .cornerRadius(16)
                    .shadow(color: .black.opacity(0.5), radius: 6, x: 0, y: 4)
                    .keyboardType(.decimalPad)
                    .onChange(of: viewModel.height) { _ in viewModel.validateWeightData()
                    }
                // Weight Input
                Text("Weight (kg)")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(.white)
                TextField("Weight (kg)", value: $viewModel.weight, formatter: NumberFormatter())
                    .font(.system(size: 24, weight: .medium))
                    .padding(.leading)
                    .frame(width: 320, height: 60)
                    .background(Color(white: 0.9))
                    .cornerRadius(16)
                    .shadow(color: .black.opacity(0.5), radius: 6, x: 0, y: 4)
                    .keyboardType(.decimalPad)
                    .onChange(of: viewModel.weight) { _ in
                        viewModel.validateWeightData()
                    }
                // Expected Weight Input
                Text("Expected Weight (kg)")
                    .font(.system(size: 20, weight: .medium))
                    .foregroundColor(.white)
                TextField("Expected Weight (kg)", value: $viewModel.expectWeight, formatter: NumberFormatter())
                    .font(.system(size: 24, weight: .medium))
                    .padding(.leading)
                    .frame(width: 320, height: 60)
                    .background(Color(white: 0.9))
                    .cornerRadius(16)
                    .shadow(color: .black.opacity(0.5), radius: 6, x: 0, y: 4)
                    .keyboardType(.decimalPad)
                    .onChange(of: viewModel.expectWeight) { _ in
                        viewModel.validateWeightData()
                    }

                if !viewModel.isWeightDataValid {
                    Text("请填写完整的身高、体重和目标体重")
                        .foregroundColor(.red)
                        .font(.system(size: 20, weight: .bold))
                }
                Spacer()
                Button(action: {
                    if viewModel.isWeightDataValid {
                        currentStep = 4 // 跳转到感谢页面
                        viewModel.register() // 调用注册函数
                    }
                }) {
                    Text("下一步")
                        .font(.system(size: 24, weight: .bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: 320, minHeight: 60)
                        .background(viewModel.isWeightDataValid ? .appGreen : Color.gray)
                        .cornerRadius(16)
                        .shadow(color: .black.opacity(0.5), radius: 6, x: 0, y: 4)
                }
                .disabled(!viewModel.isWeightDataValid)
            Spacer()
        }
    }
    
    // 3Q Page
    var thankView: some View {
        VStack {
            Spacer()
            Text("Thanks!")
                .font(.system(size: 60, weight: .bold))
                .foregroundColor(.white)
                .frame(maxWidth: .infinity)
            Text("Let's step into healthy life")
                .font(.system(size: 24, weight: .medium))
                .foregroundColor(.white)
            Text("and keey healthy diet!")
                .font(.system(size: 24, weight: .medium))
                .foregroundColor(.white)
            
            Spacer()
            Button(action: {
                isActive = true // 导航到 ContentView
            }) {
                Text("OK")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white)
                    .frame(maxWidth: 320, minHeight: 60)
                    .background(Color(red: 84/255, green: 201/255, blue: 0))
                    .cornerRadius(16)
                    .shadow(color: .black.opacity(0.5), radius: 6, x: 0, y: 4)
            }
            Spacer()
            NavigationLink(destination: ContentView().navigationBarBackButtonHidden(true)) {
                Text("Goto Content View")
                    .font(.system(size: 24, weight: .bold))
                    .foregroundColor(.white)
                    .frame(maxWidth: 320, minHeight: 60)
                    .background(Color(red: 84/255, green: 201/255, blue: 0))
                    .cornerRadius(16)
                    .shadow(color: .black.opacity(0.5), radius: 6, x: 0, y: 4)
            }
        }
    }
}

#Preview {
    RegisterView()
}
