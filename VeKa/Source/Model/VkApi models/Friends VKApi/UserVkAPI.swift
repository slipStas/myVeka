//
//  UserVkAPI.swift
//  VeKa
//
//  Created by Stanislav Slipchenko on 26.02.2020.
//  Copyright © 2020 Stanislav Slipchenko. All rights reserved.
//

import Foundation

class UserVkAPI: Codable {
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
        let id: Int
        let firstName, lastName: String
        let isClosed, canAccessClosed: Bool?
        let photo50: String
        let online: Int
        let trackCode: String
        let lists: [Int]?
        let deactivated: String?

        enum CodingKeys: String, CodingKey {
            case id
            case firstName = "first_name"
            case lastName = "last_name"
            case isClosed = "is_closed"
            case canAccessClosed = "can_access_closed"
            case photo50 = "photo_50"
            case online
            case trackCode = "track_code"
            case lists, deactivated
        }

        init(id: Int, firstName: String, lastName: String, isClosed: Bool?, canAccessClosed: Bool?, photo50: String, online: Int, trackCode: String, lists: [Int]?, deactivated: String?) {
            self.id = id
            self.firstName = firstName
            self.lastName = lastName
            self.isClosed = isClosed
            self.canAccessClosed = canAccessClosed
            self.photo50 = photo50
            self.online = online
            self.trackCode = trackCode
            self.lists = lists
            self.deactivated = deactivated
        }
    }
}


