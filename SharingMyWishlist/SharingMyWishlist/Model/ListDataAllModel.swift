//
//  CommentsModel.swift
//  SharingMyWishlist
//
//  Created by 박주영 on 2022/09/05.
//

import Foundation

struct CommentsModel: Codable {
    let id: Int
    let title, contents, writer: String
    let clear: Bool
    let color: String
    let comments: [Comment]
}
