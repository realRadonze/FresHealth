//
//  AddRecordViewModel.swift
//  FresHealth
//
//  Created by mac on 2025/2/19.
//

import SwiftUI

class AddRecordViewModel: ObservableObject {
    @Published var selectedType: RecordType = .exercise
    @Published var selectedActivity: Activity?
    @Published var count: String = ""
    @Published var activities: [Activity] = []
    @Published var showAlert = false
    @Published var alertMessage = ""
    
    let savedId = UserDefaults.standard.string(forKey: "id")

    var filteredActivities: [Activity] {
        return activities.filter { $0.type == (selectedType == .diet ? 0 : 1) }
    }

    func fetchActivities() {
        let url = URL(string: "http://localhost:8888/freshealth/findActivities.php")!
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                do {
                    let activities = try JSONDecoder().decode([Activity].self, from: data)
                    DispatchQueue.main.async {
                        self.activities = activities
                    }
                } catch {
                    print("Error decoding activities: \(error)")
                }
            } else if let error = error {
                print("Error fetching activities: \(error)")
            }
        }.resume()
    }

    func addRecord() {
        guard let selectedActivity = selectedActivity, let count = Double(count) else {
            print("Invalid input")
            return
        }

        let totalCalorie = selectedActivity.calorie * count
        let url = URL(string: "http://localhost:8888/freshealth/addRecord.php")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let formattedDate = dateFormatter.string(from: Date())
        let parameters: [String: Any] = [
            "id": savedId ?? "",
            "aid": selectedActivity.aid,
            "count": count,
            "time": formattedDate
        ]
        request.httpBody = try? JSONSerialization.data(withJSONObject: parameters)
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")

        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error adding record: \(error)")
                DispatchQueue.main.async {
                    self.showAlert = true
                    self.alertMessage = "Error adding record: \(error.localizedDescription)"
                }
                return
            }
            
            if let data = data, let responseString = String(data: data, encoding: .utf8) {
                print("Response: \(responseString)")
                DispatchQueue.main.async {
                    if responseString.contains("\"status\":\"success\"") {
                        print("Record added successfully: \(responseString)")
                        if let json = try? JSONSerialization.jsonObject(with: data, options: []) as? [String: Any],
                           let updatedCalorie = json["updated_calorie"] as? NSNumber {
                            let updatedCalorieFloat = updatedCalorie.floatValue
                            self.alertMessage = "项目: \(selectedActivity.name)\n卡路里: \(totalCalorie)\n更新后的卡路里: \(updatedCalorieFloat)"
                            // 更新 UserDefaults 中的卡路里值
                            UserDefaults.standard.set(updatedCalorieFloat, forKey: "calorie")
                        } else {
                            self.alertMessage = "项目: \(selectedActivity.name)\n卡路里: \(totalCalorie)"
                        }
                        self.showAlert = true
                    } else {
                        print("Error adding record: Invalid response.")
                        self.showAlert = true
                        self.alertMessage = "Error adding record: Invalid response."
                    }
                }
            } else {
                print("Error adding record: Unknown error.")
                DispatchQueue.main.async {
                    self.showAlert = true
                    self.alertMessage = "Error adding record: Unknown error."
                }
            }
        }
        task.resume()
    }
}
