//
//  RecordListView.swift
//  FresHealth
//
//  Created by mac on 2025/2/19.
//

import SwiftUI
import Alamofire

struct Record: Identifiable, Codable {
    var recID: Int
    var userID: Int
    var aid: Int
    var count: Double
    var time: String
    var name: String
    var calorie_per_unit: Double
    var total_calorie: Double

    var id: Int { recID }
}

struct RecordListView: View {
    @State private var records: [Record] = []
    @State private var sortOrder: SortOrder = .ascending
    @State private var sortCriteria: SortCriteria = .recID
    @State private var userTimeZone: TimeZone = TimeZone.current

    var body: some View {
        NavigationView {
            VStack {
                Picker("Sort Criteria", selection: $sortCriteria) {
                    Text("记录ID").tag(SortCriteria.recID)
                    Text("记录时间").tag(SortCriteria.time)
                    Text("卡路里").tag(SortCriteria.calories)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                Picker("Sort Order", selection: $sortOrder) {
                    Text("Ascending").tag(SortOrder.ascending)
                    Text("Descending").tag(SortOrder.descending)
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()

                List {
                    ForEach(sortedRecords) { record in
                        VStack(alignment: .leading) {
                            Text("记录ID: \(record.recID)")
                            Text("活动名称: \(record.name)")
                            Text("计数: \(String(format: "%.2f", record.count))")
                            Text("公式: \(String(format: "%.2f", record.calorie_per_unit)) * \(String(format: "%.2f", record.count))")
                            Text("卡路里: \(String(format: "%.2f", record.total_calorie))")
                            Text("时间: \(formattedTime(record.time))")
                        }
                    }
                    .onDelete(perform: deleteRecord)
                }
                .navigationTitle("记录列表")
                .onAppear {
                    fetchRecords()
                }
            }
        }
    }

    var sortedRecords: [Record] {
        switch sortCriteria {
        case .recID:
            return records.sorted {
                sortOrder == .ascending ? $0.recID < $1.recID : $0.recID > $1.recID
            }
        case .time:
            return records.sorted {
                sortOrder == .ascending ? $0.time < $1.time : $0.time > $1.time
            }
        case .calories:
            return records.sorted {
                sortOrder == .ascending ? $0.total_calorie < $1.total_calorie : $0.total_calorie > $1.total_calorie
            }
        }
    }

    func fetchRecords() {
        let url = "http://localhost:8888/freshealth/findRecord.php"
        
        AF.request(url).responseDecodable(of: [Record].self) { response in
            switch response.result {
            case .success(let records):
                DispatchQueue.main.async {
                    self.records = records
                }
            case .failure(let error):
                print("Error fetching records: \(error)")
            }
        }
    }

    func deleteRecord(at offsets: IndexSet) {
        offsets.forEach { index in
            let record = records[index]
            let url = "http://localhost:8888/freshealth/deleteRecord.php"
            let parameters: [String: Any] = ["id": record.recID]
            
            AF.request(url, method: .post, parameters: parameters, encoding: URLEncoding.default).responseJSON { response in
                switch response.result {
                case .success(let value):
                    if let json = value as? [String: Any], json["status"] as? String == "success" {
                        DispatchQueue.main.async {
                            self.records.remove(at: index)
                        }
                    } else {
                        if let json = value as? [String: Any], let message = json["message"] as? String {
                            print("Error deleting record: \(message)")
                        } else {
                            print("Error deleting record: Unknown error")
                        }
                    }
                case .failure(let error):
                    print("Error deleting record: \(error)")
                }
            }
        }
    }

    func formattedTime(_ time: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.timeZone = TimeZone(secondsFromGMT: 8 * 3600) // Input time is in GMT+8

        if let date = dateFormatter.date(from: time) {
            dateFormatter.timeZone = userTimeZone
            dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
            return dateFormatter.string(from: date)
        } else {
            return time
        }
    }
}

enum SortOrder {
    case ascending
    case descending
}

enum SortCriteria {
    case recID
    case time
    case calories
}

struct RecordListView_Previews: PreviewProvider {
    static var previews: some View {
        RecordListView()
    }
}
