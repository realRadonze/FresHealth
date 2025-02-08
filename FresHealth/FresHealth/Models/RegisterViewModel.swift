//
//  RegisterViewModel.swift
//  FresHealth
//
//  Created by mac on 2025/2/8.
//

import SwiftUI

class RegisterViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var code: String = ""
    @Published var height: Double? = nil // 初始为 nil
    @Published var weight: Double? = nil // 初始为 nil
    @Published var expectWeight: Double? = nil // 初始为 nil
    @Published var isEmailValid: Bool = false
    @Published var isPasswordValid: Bool = false
    @Published var isUsernameValid: Bool = false
    @Published var isWeightDataValid: Bool = false
    @Published var isRegistrationComplete: Bool = false

    // 验证用户名
    func validateUsername() {
        isUsernameValid = !username.isEmpty
    }

    // 验证电子邮件
    func validateEmail() {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
        let lowercasedEmail = trimmedEmail.lowercased()
        isEmailValid = emailPred.evaluate(with: lowercasedEmail)
    }

    // 验证密码
    func validatePassword() {
        let specialCharacterSet = CharacterSet(charactersIn: "!@#$%^&*()_+-=[]{}|;:'\",.<>?/")
        let hasSpecialCharacter = password.rangeOfCharacter(from: specialCharacterSet) != nil
        isPasswordValid = !password.isEmpty && password == confirmPassword && password.count >= 8 && hasSpecialCharacter
    }

    // 验证体重数据
    func validateWeightData() {
        isWeightDataValid = height != nil && weight != nil && expectWeight != nil
    }

    // 注册逻辑
    func register() {
        if isUsernameValid && isEmailValid && isPasswordValid {
            print("注册成功!")
            isRegistrationComplete = true
        } else {
            print("注册失败: 数据验证未通过")
        }
    }
    
    // 发送数据到服务器
        func sendDataToServer() {
            guard let url = URL(string: "https://127.0.0.1/freshealth/register.php") else { return }
            
            var request = URLRequest(url: url)
            request.httpMethod = "POST"
            
            let parameters: [String: Any] = [
                "username": username,
                "email": email,
                "password": password
            ]
            
            request.httpBody = try? JSONSerialization.data(withJSONObject: parameters, options: [])
            request.setValue("application/json", forHTTPHeaderField: "Content-Type")
            
            let task = URLSession.shared.dataTask(with: request) { data, response, error in
                if let error = error {
                    print("请求失败: \(error.localizedDescription)")
                    return
                }
                
                if let data = data, let responseString = String(data: data, encoding: .utf8) {
                    print("服务器响应: \(responseString)")
                }
            }
            
            task.resume()
        }
}
