//
//  Post.swift
//  mySwiftForum
//
//  Created by mac on 2025/2/4.
//

import Foundation

struct Post: Identifiable, Codable {
    var id: Int
    var title: String
    var content: String
    var comments: [Comment]
    var timestamp: TimeInterval
    var imageURL: String?
}

struct Comment: Identifiable, Codable {
    var id: Int
    var content: String
    var timestamp: Double
}
