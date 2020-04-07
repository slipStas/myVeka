//
//  GroupsVkApi.swift
//  VeKa
//
//  Created by Stanislav Slipchenko on 27.02.2020.
//  Copyright © 2020 Stanislav Slipchenko. All rights reserved.
//

import Foundation

// MARK: - GroupsVkAPI
class GroupsVkAPI: Codable {
    let response: Response

    init(response: Response) {
        self.response = response
    }
    // MARK: - Response
    class Response: Codable {
        //let count: Int
        let items: [Item]

        init(items: [Item]) {
            //self.count = count
            self.items = items
        }
    }

    // MARK: - Item
    class Item: Codable {
        let id: Int
        let name: String
//        let isClosed: Int
//        let type: TypeEnum
//        let isAdmin, isMember, isAdvertiser: Int
        let photo50: String
//        let deactivated: String?

        enum CodingKeys: String, CodingKey {
            case id, name
//            case screenName = "screen_name"
//            case isClosed = "is_closed"
//            case type
//            case isAdmin = "is_admin"
//            case isMember = "is_member"
//            case isAdvertiser = "is_advertiser"
            case photo50 = "photo_50"
//            case photo100 = "photo_100"
//            case photo200 = "photo_200"
//            case deactivated
        }

        init(id: Int, name: String/*, screenName: String, isClosed: Int, type: TypeEnum, isAdmin: Int, isMember: Int, isAdvertiser: Int*/, photo50: String/*, photo100: String, photo200: String, deactivated: String?*/) {
            self.id = id
            self.name = name
//            self.screenName = screenName
//            self.isClosed = isClosed
//            self.type = type
//            self.isAdmin = isAdmin
//            self.isMember = isMember
//            self.isAdvertiser = isAdvertiser
            self.photo50 = photo50
//            self.photo100 = photo100
//            self.photo200 = photo200
//            self.deactivated = deactivated
        }
    }

//    enum TypeEnum: String, Codable {
//        case group = "group"
//        case page = "page"
//    }
}


