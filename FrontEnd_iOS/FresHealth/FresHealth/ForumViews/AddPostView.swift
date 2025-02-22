//
//  AddPostView.swift
//  mySwiftForum
//
//  Created by mac on 2025/2/4.
//

import Foundation
import SwiftUI

struct AddPostView: View {
    @Environment(\.presentationMode) var presentationMode
    @State private var title: String = ""
    @State private var content: String = ""
    @State private var image: UIImage?
    @State private var showingImagePicker = false
    @ObservedObject var viewModel: PostViewModel

    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("Title")) {
                    TextField("Enter title", text: $title)
                }
                Section(header: Text("Content")) {
                    TextField("Enter content", text: $content)
                }
                Section(header: Text("Image")) {
                    if let image = image {
                        Image(uiImage: image)
                            .resizable()
                            .scaledToFit()
                            .frame(height: 200)
                    }
                    Button(action: {
                        showingImagePicker = true
                    }) {
                        Text("Select Image")
                    }
                }
                Button(action: {
                    // 上传图片并获取 URL
                    let imageURL = uploadImage(image)
                    viewModel.addPost(title: title, content: content, imageURL: imageURL)
                    presentationMode.wrappedValue.dismiss()
                }) {
                    Text("Add Post")
                }
            }
            .navigationTitle("Add New Post")
            .sheet(isPresented: $showingImagePicker) {
                ImagePicker(image: $image)
            }
        }
    }

    func uploadImage(_ image: UIImage?) -> String? {
        // 模拟上传图片并返回图片 URL
        // 实际实现中，你需要将图片上传到服务器并获取图片 URL
        return "https://www.google.com/images/branding/googlelogo/2x/googlelogo_color_272x92dp.png"
    }
}
