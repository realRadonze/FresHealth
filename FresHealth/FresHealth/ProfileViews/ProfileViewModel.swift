//
//  ProfileViewModel.swift
//  FresHealth
//
//  Created by mac on 2025/2/14.
//

import Foundation
import SwiftUI

class ProfileViewModel: ObservableObject {
    @Published var username: String = ""
    @Published var weight: String = ""
    @Published var height: String = ""
    @Published var expectWeight: String = ""
    @Published var avatar: UIImage?
    
    @Published var showAlert: Bool = false
    @Published var isLoggedOut: Bool = false

    init() {
        loadUserProfile()
    }

    func loadUserProfile() {
        // 从 UserDefaults 获取用户信息
        username = UserDefaults.standard.string(forKey: "username") ?? "Unknown"
        weight = UserDefaults.standard.string(forKey: "weight") ?? "0"
        height = UserDefaults.standard.string(forKey: "height") ?? "0"
        expectWeight = UserDefaults.standard.string(forKey: "expectWeight") ?? "0"
        
        // 获取头像
        if let avatarData = UserDefaults.standard.data(forKey: "avatar"), let image = UIImage(data: avatarData) {
            avatar = image
        } else {
            avatar = UIImage(named: "default")
        }
    }

    func logout() {
        // 清除 UserDefaults 中的数据
        UserDefaults.standard.removeObject(forKey: "id")
        UserDefaults.standard.removeObject(forKey: "username")
        UserDefaults.standard.removeObject(forKey: "weight")
        UserDefaults.standard.removeObject(forKey: "height")
        UserDefaults.standard.removeObject(forKey: "expectWeight")
        UserDefaults.standard.removeObject(forKey: "avatar")
        UserDefaults.standard.removeObject(forKey: "water")
        UserDefaults.standard.removeObject(forKey: "calorie")
        // 设置登出状态
        isLoggedOut = true
    }
}
