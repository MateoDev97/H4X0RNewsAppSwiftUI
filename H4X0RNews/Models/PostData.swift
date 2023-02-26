//
//  PostData.swift
//  H4X0RNews
//
//  Created by Mateo Ortiz on 26/02/23.
//

import Foundation

struct PostData: Decodable {
    let hits: [Post]
}

struct Post: Identifiable, Decodable {
    var id: String {
        return objectID
    }
    let objectID: String
    let title: String
    let points: Int
    let url: String?
}
