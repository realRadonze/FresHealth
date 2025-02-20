//
//  PostViewModel.swift
//  mySwiftForum
//
//  Created by mac on 2025/2/4.
//

import Foundation

class PostViewModel: ObservableObject {
    @Published var posts: [Post] = []

    func fetchPosts() {
        guard let url = URL(string: "http://localhost:3000/posts") else { return }
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                do {
                    let posts = try decoder.decode([Post].self, from: data)
                    DispatchQueue.main.async {
                        self.posts = posts
                    }
                } catch {
                    print("Error decoding data: \(error)")
                }
            }
        }.resume()
    }

    func addPost(title: String, content: String, imageURL: String?) {
        let newPost = Post(id: Int.random(in: 1...Int.max), title: title, content: content, comments: [], timestamp: Date().timeIntervalSince1970, imageURL: imageURL)
        guard let url = URL(string: "http://localhost:3000/posts") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(newPost)
        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                if let post = try? decoder.decode(Post.self, from: data) {
                    DispatchQueue.main.async {
                        self.posts.append(post)
                    }
                }
            }
        }.resume()
    }

    func addComment(to postId: Int, content: String) {
        guard let index = posts.firstIndex(where: { $0.id == postId }) else { return }
        let newCommentID = (posts[index].comments.last?.id ?? 0) + 1
        let newComment = Comment(id: newCommentID, content: content, timestamp: Date().timeIntervalSince1970)
        posts[index].comments.append(newComment)

        guard let url = URL(string: "http://localhost:3000/posts/\(postId)") else { return }
        var request = URLRequest(url: url)
        request.httpMethod = "PUT"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.httpBody = try? JSONEncoder().encode(posts[index])

        URLSession.shared.dataTask(with: request) { data, response, error in
            if let data = data {
                let decoder = JSONDecoder()
                if let updatedPost = try? decoder.decode(Post.self, from: data) {
                    DispatchQueue.main.async {
                        self.posts[index] = updatedPost
                    }
                }
            }
        }.resume()
    }
}
