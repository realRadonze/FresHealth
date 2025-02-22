//
//  FresHealthApp.swift
//  FresHealth
//
//  Created by mac on 2024/12/14.
//

import SwiftUI

@main
struct FresHealthApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            if UserDefaults.standard.bool(forKey: "isLoggedIn") {
                ContentView()
            } else {
                LoginView()
            }
        }
    }
}
