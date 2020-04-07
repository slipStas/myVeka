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
        let items: [Item]
        
        init(items: [Item]) {
            self.items = items
        }
    }
    
    // MARK: - Item
    class Item: Codable {
        let id: Int
        let firstName, lastName: String
        let photo50: String
        
        enum CodingKeys: String, CodingKey {
            case id
            case firstName = "first_name"
            case lastName = "last_name"
            case photo50 = "photo_50"
        }
        
        init(id: Int, firstName: String, lastName: String, photo50: String) {
            self.id = id
            self.firstName = firstName
            self.lastName = lastName
            self.photo50 = photo50
        }
    }
}


