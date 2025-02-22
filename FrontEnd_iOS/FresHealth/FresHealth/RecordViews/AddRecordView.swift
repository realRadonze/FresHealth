import SwiftUI

struct AddRecordView: View {
    @StateObject private var viewModel = AddRecordViewModel()
    @State private var searchText = ""
    @State private var sortAscending = true

    var body: some View {
        VStack {
            // 第一层：选择记录类型
            HStack {
                Button(action: {
                    viewModel.selectedType = .diet
                    viewModel.fetchActivities()
                }) {
                    Text("Food")
                        .padding()
                        .background(viewModel.selectedType == .diet ? Color.blue : Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                Button(action: {
                    viewModel.selectedType = .exercise
                    viewModel.fetchActivities()
                }) {
                    Text("Sport")
                        .padding()
                        .background(viewModel.selectedType == .exercise ? Color.blue : Color.gray)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
                Button(action: {
                    sortAscending.toggle()
                }) {
                    Text(sortAscending ? "calAsc" : "calDesc")
                        .padding()
                        .background(sortAscending ? Color.cyan : Color.pink)
                        .foregroundColor(.white)
                        .cornerRadius(8)
                }
            }
            .padding()

            // 第二层：搜索框、排序按钮和选择项目
            VStack {
                TextField("search", text: $searchText)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .padding(.horizontal)

                List(viewModel.filteredActivities.filter {
                    searchText.isEmpty ? true : $0.name.contains(searchText)
                }.sorted(by: {
                    sortAscending ? $0.calorie < $1.calorie : $0.calorie > $1.calorie
                }), id: \.aid) { activity in
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
            }

            // 第三层：输入计数并确认添加
            HStack {
                TextField("count", text: $viewModel.count)
                    .keyboardType(.decimalPad)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)

                Button(action: {
                    viewModel.addRecord()
                }) {
                    Text("confirm")
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
            Alert(title: Text("recSuccess"), message: Text(viewModel.alertMessage), dismissButton: .default(Text("confirm")))
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
