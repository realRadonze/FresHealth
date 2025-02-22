//
//  RegisterViewModel.swift
//  FresHealth
//
//  Created by mac on 2025/2/8.
//

import SwiftUI
import Alamofire

class RegisterViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var email: String = ""
    @Published var password: String = ""
    @Published var confirmPassword: String = ""
    @Published var code: String = ""
    @Published var height: Float? = nil
    @Published var weight: Float? = nil
    @Published var expectWeight: Float? = nil
    @Published var isEmailValid: Bool = false
    @Published var isPasswordValid: Bool = false
    @Published var isUsernameValid: Bool = false
    @Published var isWeightDataValid: Bool = false
    @Published var isRegistrationComplete: Bool = false
    
    @Published var loginSuccess: Bool = false

    // Validate Logic
    func validateUsername() {
        isUsernameValid = !username.isEmpty
    }

    func validateEmail() {
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format: "SELF MATCHES %@", emailRegEx)
        let trimmedEmail = email.trimmingCharacters(in: .whitespacesAndNewlines)
        let lowercasedEmail = trimmedEmail.lowercased()
        isEmailValid = emailPred.evaluate(with: lowercasedEmail)
    }

    func validatePassword() {
        let specialCharacterSet = CharacterSet(charactersIn: "!@#$%^&*()_+-=[]{}|;:'\",.<>?/")
        let hasSpecialCharacter = password.rangeOfCharacter(from: specialCharacterSet) != nil
        isPasswordValid = !password.isEmpty && password == confirmPassword && password.count >= 8 && hasSpecialCharacter
    }
    
    func validateWeightData() {
        isWeightDataValid = height != nil && weight != nil && expectWeight != nil
    }
    
    // Register logic
    func register(username: String, password: String, email: String, height: Float, weight: Float, expectWeight: Float) {
        let url = URL(string: "http://localhost:8888/freshealth/register.php")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let parameters: [String: String] = [
            "username": username,
            "password": password,
            "email": email,
            "height": String(height),
            "weight": String(weight),
            "expectWeight": String(expectWeight)
        ]
        
        request.httpBody = parameters
            .map { "\($0.key)=\($0.value)" }
            .joined(separator: "&")
            .data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Registration failed: \(error)")
                return
            }
            
            if let data = data, let responseString = String(data: data, encoding: .utf8) {
                print("Registration successful: \(responseString)")

            } else {
                print("Registration failed: Unknown error.")
            }
        }
        task.resume()
    }    
}

