//
//  UserVCApi.swift
//  VeKa
//
//  Created by Stanislav Slipchenko on 26.02.2020.
//  Copyright © 2020 Stanislav Slipchenko. All rights reserved.
//

import Foundation

class UserVCApi: Codable {
    let response: Response

    init(response: Response) {
        self.response = response
    }
}

class Response: Codable {
    let count: Int
    let items: [Item]

    init(count: Int, items: [Item]) {
        self.count = count
        self.items = items
    }
}

class Item: Codable {
    let id: Int
    let firstName, lastName: String
    let isClosed, canAccessClosed: Bool?
    let photo200_Orig: String
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
        case photo200_Orig = "photo_200_orig"
        case online
        case trackCode = "track_code"
        case lists, deactivated
    }

    init(id: Int, firstName: String, lastName: String, isClosed: Bool?, canAccessClosed: Bool?, photo200_Orig: String, online: Int, trackCode: String, lists: [Int]?, deactivated: String?) {
        self.id = id
        self.firstName = firstName
        self.lastName = lastName
        self.isClosed = isClosed
        self.canAccessClosed = canAccessClosed
        self.photo200_Orig = photo200_Orig
        self.online = online
        self.trackCode = trackCode
        self.lists = lists
        self.deactivated = deactivated
    }
}
