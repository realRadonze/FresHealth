//
//  AddRecordView.swift
//  FresHealth
//
//  Created by mac on 2025/2/19.
//

import SwiftUI

struct AddRecordView: View {
    @StateObject private var viewModel = AddRecordViewModel()

    var body: some View {
        VStack {
            // 第一层：选择记录类型
            HStack {
                Button(action: {
                    viewModel.selectedType = .diet
                    viewModel.fetchActivities()
                }) {
                    Text("记录饮食")
                        .padding()
                        .background(viewModel.selectedType == .diet ? Color.blue : Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                Button(action: {
                    viewModel.selectedType = .exercise
                    viewModel.fetchActivities()
                }) {
                    Text("记录运动")
                        .padding()
                        .background(viewModel.selectedType == .exercise ? Color.blue : Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .padding()

            // 第二层：选择项目
            List(viewModel.filteredActivities, id: \.aid) { activity in
                VStack(alignment: .leading) {
                    HStack {
                        Text(activity.name)
                        Spacer()
                        if viewModel.selectedActivity?.aid == activity.aid {
                            Image(systemName: "checkmark")
                        }
                    }
                    Text("描述: \(activity.description)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text("卡路里: \(activity.calorie, specifier: "%.2f")")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .contentShape(Rectangle())
                .onTapGesture {
                    viewModel.selectedActivity = activity
                }
            }
            .padding()

            // 第三层：输入计数并确认添加
            HStack {
                TextField("输入计数", text: $viewModel.count)
                    .keyboardType(.decimalPad)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)

                Button(action: {
                    viewModel.addRecord()
                }) {
                    Text("确认添加")
                        .padding()
                        .background(Color.green)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .padding()
        }
        .onAppear {
            viewModel.fetchActivities()
        }
        .alert(isPresented: $viewModel.showAlert) {
            Alert(title: Text("记录添加成功"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("确定")))
        }
    }
}

enum RecordType {
    case diet
    case exercise
}

struct Activity: Identifiable, Codable, Hashable {
    var aid: Int
    var type: Int
    var name: String
    var description: String
    var calorie: Double

    var id: Int { aid }
}

struct AddRecordView_Previews: PreviewProvider {
    static var previews: some View {
        AddRecordView()
    }
}
