//
//  SettingsView.swift
//  FresHealth
//
//  Created by mac on 2025/2/20.
//

import SwiftUI

struct SettingsView: View {
    @State private var selectedImage: UIImage?
    @State private var isImagePickerPresented = false
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var avatar: UIImage?

    let savedId = UserDefaults.standard.string(forKey: "id")

    var body: some View {
        VStack {

            Button(action: {
                isImagePickerPresented = true
            }) {
                if let selectedImage = selectedImage {
                    Image(uiImage: selectedImage)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 4))
                        .shadow(radius: 10)
                } else if let avatar = avatar {
                    Image(uiImage: avatar)
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 4))
                        .shadow(radius: 10)
                } else {
                    Image("default")
                        .resizable()
                        .scaledToFit()
                        .frame(width: 200, height: 200)
                        .clipShape(Circle())
                        .overlay(Circle().stroke(Color.white, lineWidth: 4))
                        .shadow(radius: 10)
                }
            }
            .padding()

            Button(action: {
                uploadPhoto()
            }) {
                Text("uploadAva")
                    .padding()
                    .background(Color.green)
                    .foregroundColor(.white)
                    .cornerRadius(10)
            }
            .padding()
            .disabled(selectedImage == nil)
        }
        .sheet(isPresented: $isImagePickerPresented) {
            ImagePicker(image: $selectedImage)
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("提示"), message: Text(alertMessage), dismissButton: .default(Text("确定")))
        }
        .onAppear {
            loadAvatar()
        }
    }

    func loadAvatar() {
        if let avatarURLString = UserDefaults.standard.string(forKey: "avatarURL"),
           let avatarURL = URL(string: avatarURLString) {
            DispatchQueue.global().async {
                if let data = try? Data(contentsOf: avatarURL), let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self.avatar = image
                    }
                } else {
                    DispatchQueue.main.async {
                        self.avatar = UIImage(named: "default")
                    }
                }
            }
        } else {
            avatar = UIImage(named: "default")
        }
    }

    func uploadPhoto() {
        guard let selectedImage = selectedImage else {
            alertMessage = "请选择一张图片。"
            showAlert = true
            return
        }

        guard let savedId = savedId else {
            alertMessage = "用户ID未找到。"
            showAlert = true
            return
        }

        // 压缩图片
        var imageData = selectedImage.jpegData(compressionQuality: 1.0)
        let maxFileSize: Int = 1000000
        var compressionQuality: CGFloat = 1.0

        while let data = imageData, data.count > maxFileSize && compressionQuality > 0 {
            compressionQuality -= 0.1
            imageData = selectedImage.jpegData(compressionQuality: compressionQuality)
        }

        guard let compressedImageData = imageData else {
            alertMessage = "无法压缩图片。"
            showAlert = true
            return
        }

        // 生成文件名
        guard let filename = generateFilename(for: selectedImage) else {
            alertMessage = "无法生成文件名。"
            showAlert = true
            return
        }

        let url = URL(string: "http://localhost:8888/freshealth/uploadPhoto.php")!
        print("Uploading photo to URL: \(url)")
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        let boundary = UUID().uuidString
        request.setValue("multipart/form-data; boundary=\(boundary)", forHTTPHeaderField: "Content-Type")

        var body = Data()
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"file\"; filename=\"\(filename)\"\r\n".data(using: .utf8)!)
        body.append("Content-Type: image/jpeg\r\n\r\n".data(using: .utf8)!)
        body.append(compressedImageData)
        body.append("\r\n--\(boundary)--\r\n".data(using: .utf8)!)

        // Add user ID to the request body
        body.append("--\(boundary)\r\n".data(using: .utf8)!)
        body.append("Content-Disposition: form-data; name=\"id\"\r\n\r\n".data(using: .utf8)!)
        body.append("\(savedId)\r\n".data(using: .utf8)!)
        body.append("--\(boundary)--\r\n".data(using: .utf8)!)

        request.httpBody = body

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error uploading photo: \(error)")
                DispatchQueue.main.async {
                    self.alertMessage = "上传失败：\(error.localizedDescription)"
                    self.showAlert = true
                }
                return
            }

            if let data = data, let responseString = String(data: data, encoding: .utf8) {
                print("Response: \(responseString)")
                if let jsonData = responseString.data(using: .utf8),
                   let jsonResponse = try? JSONSerialization.jsonObject(with: jsonData, options: []) as? [String: Any],
                   let status = jsonResponse["status"] as? String, status == "success",
                   let avatarURL = jsonResponse["url"] as? String {
                    updateAvatarURL(avatarURL: avatarURL)
                    UserDefaults.standard.set(avatarURL, forKey: "avatarURL")
                    DispatchQueue.main.async {
                        self.loadAvatar() // Reload the avatar image
                    }
                } else {
                    DispatchQueue.main.async {
                        self.alertMessage = "上传失败：\(responseString)"
                        self.showAlert = true
                    }
                }
            }
        }.resume()
    }

    func updateAvatarURL(avatarURL: String) {
        guard let savedId = savedId else {
            alertMessage = "用户ID未找到。"
            showAlert = true
            return
        }

        let url = URL(string: "http://localhost:8888/freshealth/updateAvatar.php")!
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/x-www-form-urlencoded", forHTTPHeaderField: "Content-Type")

        let parameters: [String: Any] = [
            "id": savedId,
            "avatar": avatarURL
        ]
        request.httpBody = parameters.map { "\($0.key)=\($0.value)" }.joined(separator: "&").data(using: .utf8)

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                print("Error updating avatar URL: \(error)")
                DispatchQueue.main.async {
                    self.alertMessage = "头像更新失败：\(error.localizedDescription)"
                    self.showAlert = true
                }
                return
            }

        }.resume()
    }

    func generateFilename(for image: UIImage) -> String? {
        // Retrieve the id from UserDefaults
        guard let id = UserDefaults.standard.string(forKey: "id") else {
            print("User ID not found.")
            return nil
        }

        // Determine the file extension based on the image type
        let fileExtension: String
        if let _ = image.pngData() {
            fileExtension = "png"
        } else if let _ = image.jpegData(compressionQuality: 1.0) {
            fileExtension = "jpg"
        } else {
            print("Unsupported image format.")
            return nil
        }

        // Generate the filename
        let filename = "\(id)_avatar.\(fileExtension)"
        return filename
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView()
    }
}
