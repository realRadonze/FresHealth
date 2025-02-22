//
//  LoginViewModel.swift
//  FresHealth
//
//  Created by mac on 2025/2/13.
//

import Foundation
import SwiftUI

class LoginViewModel: ObservableObject {
    @Published var id: Int = 0
    @Published var username: String = ""
    @Published var password: String = ""
    @Published var email: String = ""
    @Published var avatar: UIImage?
    @Published var height: Double = 0.0
    @Published var weight: Double = 0.0
    @Published var expectWeight: Double = 0.0
    @Published var calorie: Double = 0.0
    @Published var water: Int = 0
    @Published var loginSuccess: Bool = false
    @Published var showAlert: Bool = false
    @Published var alertMessage: String = ""

    func login(completion: @escaping (Bool) -> Void) {
        guard let url = URL(string: "http://localhost:8888/freshealth/login.php") else {
            print("Invalid URL")
            return
        }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        let parameters: [String: String] = [
            "username": username,
            "password": password
        ]
        
        request.httpBody = parameters
            .map { "\($0.key)=\($0.value)" }
            .joined(separator: "&")
            .data(using: .utf8)
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Login failed: \(error)")
                DispatchQueue.main.async {
                    self.showAlert = true
                    self.alertMessage = "Login failed: \(error.localizedDescription)"
                    completion(false)
                }
                return
            }
            
            if let data = data, let responseString = String(data: data, encoding: .utf8) {
                print("Response: \(responseString)")
                DispatchQueue.main.async {
                    if responseString.contains("\"success\":true") {
                        print("Login successful: \(responseString)")
                        self.loginSuccess = true
                        // Assuming the response contains the additional user information
                        if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                            self.id = json["userId"] as? Int ?? 0
                            self.email = json["email"] as? String ?? ""
                            self.height = json["height"] as? Double ?? 0.0
                            self.weight = json["weight"] as? Double ?? 0.0
                            self.expectWeight = json["expectWeight"] as? Double ?? 0.0
                            self.calorie = json["calorie"] as? Double ?? 0.0
                            self.water = json["water"] as? Int ?? 0
                        }
                        UserDefaults.standard.set(true, forKey: "isLoggedIn")
                        UserDefaults.standard.set(self.id, forKey: "id")
                        UserDefaults.standard.set(self.username, forKey: "username")
                        UserDefaults.standard.set(self.avatar, forKey: "avatar")
                        UserDefaults.standard.set(self.email, forKey: "email")
                        UserDefaults.standard.set(self.password, forKey: "password")
                        UserDefaults.standard.set(self.height, forKey: "height")
                        UserDefaults.standard.set(self.weight, forKey: "weight")
                        UserDefaults.standard.set(self.expectWeight, forKey: "expectWeight")
                        UserDefaults.standard.set(self.calorie, forKey: "calorie")
                        UserDefaults.standard.set(self.water, forKey: "water")
                        completion(true)
                    } else {
                        print("Login failed: Invalid username or password.")
                        self.loginSuccess = false
                        self.showAlert = true
                        self.alertMessage = "Invalid username or password."
                        completion(false)
                    }
                }
            } else {
                print("Login failed: Unknown error.")
                DispatchQueue.main.async {
                    self.showAlert = true
                    self.alertMessage = "Login failed: Unknown error."
                    completion(false)
                }
            }
        }
        task.resume()
    }
}
