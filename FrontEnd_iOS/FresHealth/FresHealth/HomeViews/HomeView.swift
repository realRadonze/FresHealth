//
//  HomeView.swift
//  FresHealth
//
//  Created by mac on 2025/2/6.
//

import SwiftUI

struct HomeView: View {
    
    @StateObject private var viewModel = ProfileViewModel()
    @State private var username: String = UserDefaults.standard.string(forKey: "username") ?? ""
    @State private var water: Int = UserDefaults.standard.integer(forKey: "water")
    @State private var calorie: Double = UserDefaults.standard.double(forKey: "calorie")
    @State private var totalWater: Int = 8
    @State private var totalCalorie: Double = 2000.0 // Change to TDEE

    var body: some View {
        NavigationView {
            VStack {
                ZStack {
                    Color(white: 0.9)
                        .cornerRadius(4)
                        .frame(maxWidth: .infinity, maxHeight: 80)
                        .shadow(color: .black.opacity(0.5), radius: 6, x: 0, y: 4)
                    VStack {
                        Text("FresHealth")
                            .font(.system(size: 28, weight:.medium))
                            .foregroundColor(Color.black)
                        Text("Welcome, \(username)!")
                            .font(.system(size: 18, weight:.light))
                            .foregroundColor(.black)
                    }
                    .onAppear {
                        username = UserDefaults.standard.string(forKey: "username") ?? "Unknown"
                        water = UserDefaults.standard.integer(forKey: "water")
                        calorie = UserDefaults.standard.double(forKey: "calorie")
                    }
                    
                    HStack {
                        Spacer()
                            NavigationLink(destination: ProfileView()) {
                            if let avatar = viewModel.avatar {
                                Image(uiImage: avatar)
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                    .cornerRadius(30)
                                    .padding(.trailing)
                            } else {
                                Image("default")
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                    .cornerRadius(30)
                                    .padding(.trailing)
                            }
                        }
                    }
                }
                
                HStack {
                    // water
                    NavigationLink(destination: WaterView()) {
                        ZStack {
                            Color(white: 0.9)
                                .cornerRadius(16)
                                .frame(maxWidth: .infinity, minHeight:220)
                                .shadow(color: .black.opacity(0.3), radius: 6, x: 4, y: 4)
                            GeometryReader { geometry in
                                ZStack(alignment: .bottom) {
                                    Rectangle()
                                        .frame(width: geometry.size.width, height: geometry.size.height)
                                        .foregroundColor(.blue)
                                        .opacity(0.3)
                                    
                                    Rectangle()
                                        .frame(width: geometry.size.width, height: min(CGFloat(self.water) / CGFloat(self.totalWater) * geometry.size.height, geometry.size.height))
                                        .foregroundColor(.blue)
                                        .animation(.linear)
                                }
                                .cornerRadius(16)
                            }
                            VStack(alignment: .leading) {
                                Spacer()
                                Text("water")
                                    .font(.system(size: 20, weight:.medium))
                                    .multilineTextAlignment(.leading)
                                    .foregroundColor(.black)
                                Text("\(water)/\(totalWater) cups")
                                    .font(.system(size: 28, weight:.medium))
                                    .multilineTextAlignment(.leading)
                                    .foregroundColor(.black)
                            }
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    
                    // calorie
                    NavigationLink(destination: RecordListView()) {
                        ZStack {
                            Color(white: 0.9)
                                .cornerRadius(16)
                                .frame(maxWidth: .infinity, minHeight: 220)
                                .shadow(color: .black.opacity(0.3), radius: 6, x: 4, y: 4)
                            GeometryReader { geometry in
                                ZStack(alignment: .bottom) {
                                    Rectangle()
                                        .frame(width: geometry.size.width, height: geometry.size.height)
                                        .foregroundColor(.orange)
                                        .opacity(0.3)
                                    
                                    Rectangle()
                                        .frame(width: geometry.size.width, height: min(CGFloat(self.calorie) / CGFloat(self.totalCalorie) * geometry.size.height, geometry.size.height))
                                        .foregroundColor(.orange)
                                        .animation(.linear)
                                }
                                .cornerRadius(16)
                            }
                            VStack(alignment: .leading) {
                                Spacer()
                                Text("calories")
                                    .font(.system(size: 20, weight: .medium))
                                    .multilineTextAlignment(.leading)
                                    .foregroundColor(.black)
                                Text("\(Int(calorie))/\(Int(totalCalorie))")
                                    .font(.system(size: 24, weight: .medium))
                                    .multilineTextAlignment(.leading)
                                    .foregroundColor(.black)
                            }
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                }
                .padding(.vertical)
                
                ZStack {
                    Color(white: 0.9)
                        .cornerRadius(4)
                        .frame(maxWidth: .infinity, minHeight: 80)
                        .shadow(color: .black.opacity(0.5), radius: 6, x: 0, y: 4)
                    HStack {
                        VStack(alignment: .leading) {
                            Text("weight")
                                .font(.system(size: 28, weight:.medium))
                                .foregroundColor(Color.black)
                            Text("exWeight")
                                .font(.system(size: 18, weight:.light))
                                .foregroundColor(.black)
                        }
                        Spacer()
                    }
                    .padding(.leading, 20)
                    
                    HStack {
                        Spacer()
                        VStack(alignment: .trailing) {
                            Text("\(viewModel.weight) kg")
                                .font(.system(size: 28, weight:.medium))
                                .foregroundColor(Color.black)
                            Text("\(viewModel.expectWeight) kg")
                                .font(.system(size: 18, weight:.light))
                                .foregroundColor(.black)
                        }
                    }
                    .padding(.trailing, 20)
                }
                
                NavigationLink(destination: AddRecordView()) {
                    Text("addRecord")
                        .font(.system(size: 32, weight:.medium))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, minHeight: 100)
                        .background(Color.appGreen)
                        .cornerRadius(16)
                }
                .padding(.top, 20)
                
                NavigationLink(destination: AIView(url: URL(string: "https://chat.deepseek.com")!)) {
                    Text("ai")
                        .font(.system(size: 32, weight:.bold))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, minHeight: 100)
                        .background(LinearGradient(gradient: Gradient(colors: [Color.purple, Color.indigo]), startPoint: .top, endPoint: .bottom)) //front
                        .cornerRadius(8)
                        .padding(8)
                        .background(LinearGradient(gradient: Gradient(colors: [Color.teal, Color.teal, Color.red, Color.purple, Color.cyan]), startPoint: .leading, endPoint: .trailing))
                        .cornerRadius(16)
                }
                .padding(.vertical, 20)
                
            }
            .padding()
            .navigationBarBackButtonHidden(true)
        }
        .onAppear {
            viewModel.loadUserProfile()
        }
    }
}

#Preview {
    HomeView()
}
