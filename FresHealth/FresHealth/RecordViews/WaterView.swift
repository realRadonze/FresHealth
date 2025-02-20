//
//  WaterView.swift
//  FresHealth
//
//  Created by mac on 2025/2/5.
//

import SwiftUI

struct WaterView: View {
    @State private var showAlert = false
    @State private var alertMessage = "您已喝水！"
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        NavigationView {
            VStack {
                Text(alertMessage)
                    .font(.largeTitle)
                    .padding()

                Button(action: {
                    addWater()
                }) {
                    Text("OK")
                        .font(.title)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .alert(isPresented: $showAlert) {
                    Alert(title: Text("Update"), message: Text(alertMessage), dismissButton: .default(Text("OK")) {
                        // 返回 HomeView
                        self.presentationMode.wrappedValue.dismiss()
                    })
                }
            }
        }
        .navigationBarBackButtonHidden()
    }

    func addWater() {
        // 从 UserDefaults 获取用户 ID
        guard let userId = UserDefaults.standard.value(forKey: "id") as? Int else {
            print("User ID not found in UserDefaults")
            return
        }

        // 向服务器发送请求，增加 water 值
        let url = URL(string: "http://localhost:8888/freshealth/addWater.php")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let parameters: [String: Any] = ["id": userId] // 使用从 UserDefaults 获取的用户 ID
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data, let responseString = String(data: data, encoding: .utf8) {
                DispatchQueue.main.async {
                    if responseString.contains("\"status\":\"success\"") {
                        // 更新 UserDefaults 中的 water 值
                        var currentWater = UserDefaults.standard.integer(forKey: "water")
                        currentWater += 1
                        UserDefaults.standard.set(currentWater, forKey: "water")
                        self.alertMessage = "您已喝水！"
                    } else {
                        self.alertMessage = "Failed to update water count."
                    }
                    self.showAlert = true
                }
            }
        }.resume()
    }
}
