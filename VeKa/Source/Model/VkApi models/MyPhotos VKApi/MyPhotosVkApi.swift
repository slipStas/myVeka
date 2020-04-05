//
//  MyPhotosVkApi.swift
//  VeKa
//
//  Created by Stanislav Slipchenko on 27.02.2020.
//  Copyright © 2020 Stanislav Slipchenko. All rights reserved.
//

import Foundation

// MARK: - MyPhotosVkAPI
class MyPhotosVkAPI: Codable {
    let response: Response

    init(response: Response) {
        self.response = response
    }
    
    // MARK: - Response
    class Response: Codable {
        let count: Int
        let items: [Item]

        init(count: Int, items: [Item]) {
            self.count = count
            self.items = items
        }
    }

    // MARK: - Item
    class Item: Codable {
        let id/*, albumID, ownerID*/: Int
        let sizes: [Size]
//        let text: String
//        let date: Int
//        let postID: Int?
//        let lat, long: Double?

        enum CodingKeys: String, CodingKey {
            case id
//            case albumID = "album_id"
//            case ownerID = "owner_id"
            case sizes//, text, date
//            case postID = "post_id"
//            case lat, long
        }

        init(id: Int/*, albumID: Int, ownerID: Int*/, sizes: [Size]/*, text: String, date: Int, postID: Int?, lat: Double?, long: Double?*/) {
            self.id = id
//            self.albumID = albumID
//            self.ownerID = ownerID
            self.sizes = sizes
//            self.text = text
//            self.date = date
//            self.postID = postID
//            self.lat = lat
//            self.long = long
        }
    }

    // MARK: - Size
    class Size: Codable {
        let type: TypeEnum
        let url: String
        let width, height: Int

        init(type: TypeEnum, url: String, width: Int, height: Int) {
            self.type = type
            self.url = url
            self.width = width
            self.height = height
        }
    }

    enum TypeEnum: String, Codable {
        case m = "m"
        case o = "o"
        case p = "p"
        case q = "q"
        case r = "r"
        case s = "s"
        case w = "w"
        case x = "x"
        case y = "y"
        case z = "z"
    }
}
