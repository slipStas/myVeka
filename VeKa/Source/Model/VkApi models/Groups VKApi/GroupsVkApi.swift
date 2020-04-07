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
        let items: [Item]
        
        init(items: [Item]) {
            self.items = items
        }
    }
    
    // MARK: - Item
    class Item: Codable {
        let id: Int
        let name: String
        let photo50: String
        
        enum CodingKeys: String, CodingKey {
            case id, name
            case photo50 = "photo_50"
        }
        
        init(id: Int, name: String, photo50: String) {
            self.id = id
            self.name = name
            self.photo50 = photo50
        }
    }
}


