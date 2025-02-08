//
//  PostCommentView.swift
//  mySwiftForum
//
//  Created by mac on 2025/2/4.
//

import Foundation
import SwiftUI

private let dateFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .medium
    formatter.timeStyle = .short
    return formatter
}()

struct PostCommentView: View {
    var post: Post
    @State private var newCommentContent: String = ""
    @EnvironmentObject var viewModel: PostViewModel
    @Environment(\.presentationMode) var presentationMode

    var body: some View {
        VStack {
            List(post.comments) { comment in
                VStack(alignment: .leading) {
                    Text("Comment ID: \(comment.id)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                    Text(comment.content)
                        .font(.body)
                    Text("\(Date(timeIntervalSince1970: comment.timestamp), formatter: dateFormatter)")
                        .font(.subheadline)
                        .foregroundColor(.gray)
                }
                .padding(.vertical, 5)
            }

            HStack {
                TextField("Enter your comment", text: $newCommentContent)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()

                Button(action: {
                    viewModel.addComment(to: post.id, content: newCommentContent)
                    newCommentContent = ""
                }) {
                    Text("Send")
                        .font(.headline)
                        .padding()
                        .background(Color.blue)
                        .foregroundColor(.white)
                        .cornerRadius(10)
                }
                .padding()
            }
            .padding(.horizontal)
        }
    }
}
