//
//  HomeView.swift
//  FresHealth
//
//  Created by mac on 2025/2/6.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        NavigationView {
            VStack {
                // top bar
                ZStack {
                    Color(white: 0.9)
                        .cornerRadius(4)
                        .frame(maxWidth: .infinity, minHeight: 80)
                        .shadow(color: .black.opacity(0.5), radius: 6, x: 0, y: 4)
                    VStack {
                        Text("FresHealth") // app name
                            .font(.system(size: 28, weight:.medium))
                            .foregroundColor(Color.black)
                        Text("Drink more water!") // status
                            .font(.system(size: 18, weight:.light))
                            .foregroundColor(.black)
                    }
                    HStack {
                        Spacer()
                        Image(systemName: "globe") //user avatar
                            .resizable()
                            .background(Color.orange)
                            .frame(width: 60, height: 60)
                            .cornerRadius(30)
                            .padding(.trailing)
                    }
                }
                // water and calories
                HStack {
                    // water
                    NavigationLink(destination: WaterView()) {
                        ZStack {
                            Color(white: 0.9)
                                .cornerRadius(16)
                                .frame(maxWidth: .infinity, minHeight:220)
                                .shadow(color: .black.opacity(0.3), radius: 6, x: 4, y: 4)
                            VStack(alignment: .leading) {
                                Spacer()
                                Text("water")
                                    .font(.system(size: 20, weight:.medium))
                                    .multilineTextAlignment(.leading)
                                    .foregroundColor(.black)
                                Text("2/8 cups")
                                    .font(.system(size: 28, weight:.medium))
                                    .multilineTextAlignment(.leading)
                                    .foregroundColor(.black)
                            }
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                    
                    // calorie
                    NavigationLink(destination: WaterView()) {
                        ZStack {
                            Color(white: 0.9)
                                .cornerRadius(16)
                                .frame(maxWidth: .infinity, minHeight:220)
                                .shadow(color: .black.opacity(0.3), radius: 6, x: 4, y: 4)
                            VStack(alignment: .leading) {
                                Spacer()
                                Text("calories")
                                    .font(.system(size: 20, weight:.medium))
                                    .multilineTextAlignment(.leading)
                                    .foregroundColor(.black)
                                Text("1000/2000")
                                    .font(.system(size: 28, weight:.medium))
                                    .multilineTextAlignment(.leading)
                                    .foregroundColor(.black)
                            }
                            .padding()
                            .frame(maxWidth: .infinity, alignment: .leading)
                        }
                    }
                }
                .padding(.vertical)
                
                // top bar
                ZStack {
                    Color(white: 0.9)
                        .cornerRadius(4)
                        .frame(maxWidth: .infinity, minHeight: 80)
                        .shadow(color: .black.opacity(0.5), radius: 6, x: 0, y: 4)
                    HStack {
                        VStack(alignment: .leading) {
                            Text("Weight") // app name
                                .font(.system(size: 28, weight:.medium))
                                .foregroundColor(Color.black)
                            Text("Expected Weight") // status
                                .font(.system(size: 18, weight:.light))
                                .foregroundColor(.black)
                        }
                        Spacer()
                    }
                    .padding(.leading, 20)
                    
                    HStack {
                        Spacer()
                        VStack(alignment: .trailing) {
                            Text("80kg") // app name
                                .font(.system(size: 28, weight:.medium))
                                .foregroundColor(Color.black)
                            Text("70kg") // status
                                .font(.system(size: 18, weight:.light))
                                .foregroundColor(.black)
                        }
                    }
                    .padding(.trailing, 20)
                }
                
                NavigationLink(destination: WaterView()) {
                    Text("Add Record")
                        .font(.system(size: 32, weight:.medium))
                        .foregroundColor(.white)
                        .frame(maxWidth: .infinity, minHeight: 100)
                        .background(Color.green)
                        .cornerRadius(16)
                }
                .padding(.top, 20)
                
                NavigationLink(destination: AIView()) {
                    Text("AI Helper")
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
            .navigationBarBackButtonHidden(true) // Hide Back Btn
        }
    }
}

#Preview {
    HomeView()
}

