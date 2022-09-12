//
//  CommentModel.swift
//  SharingMyWishlist
//
//  Created by 박주영 on 2022/09/05.
//

import Foundation

// MARK: - CommentResponseList
struct CommentResponseList: Codable {
    let id: Int
    let nickName, comment, createdAt: String
}
