//
//  ListDataModelElement.swift
//  SharingMyWishlist
//
//  Created by 박주영 on 2022/09/05.
//

import Foundation


// MARK: - ListDataModelElement
struct ListDataModelElement: Codable {
    let id: Int
    let title, contents, writer: String
    let clear: Bool
    let color, createdAt: String
}
