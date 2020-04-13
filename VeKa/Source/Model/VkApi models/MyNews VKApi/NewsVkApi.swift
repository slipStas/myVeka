//
//  NewsVkApi.swift
//  VeKa
//
//  Created by Stanislav Slipchenko on 03.04.2020.
//  Copyright © 2020 Stanislav Slipchenko. All rights reserved.
//

import Foundation

// MARK: - NewsVkAPI
class NewsVkAPI: Codable {
    let response: Response
    
    init(response: Response) {
        self.response = response
    }
    // MARK: - Response
    class Response: Codable {
        let items: [Item]
        let profiles: [Profile]
        let groups: [Group]
        let nextFrom: String
        
        enum CodingKeys: String, CodingKey {
            case items, profiles, groups
            case nextFrom = "next_from"
        }
        
        init(items: [Item], profiles: [Profile], groups: [Group], nextFrom: String) {
            self.items = items
            self.profiles = profiles
            self.groups = groups
            self.nextFrom = nextFrom
        }
    }
    
    // MARK: - Group
    class Group: Codable {
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
    
    enum GroupType: String, Codable {
        case group = "group"
        case page = "page"
    }
    
    // MARK: - Item
    class Item: Codable {
        let text: String
        let sourceID: Int
        let attachments: [ItemAttachment]?
        
        enum CodingKeys: String, CodingKey {
            case attachments
            case sourceID = "source_id"
            case text
        }
        
        init(sourceID: Int, text: String, attachments: [ItemAttachment]?) {
            self.attachments = attachments
            self.sourceID = sourceID
            self.text = text
        }
    }
    
    // MARK: - ItemAttachment
    class ItemAttachment: Codable {
        let photo: AttachmentPhoto?

        init(photo: AttachmentPhoto?) {
            self.photo = photo
           
        }
    }
    
    // MARK: - AttachmentPhoto
    class AttachmentPhoto: Codable {
        let sizes: [Size]
        let text: String

//        enum CodingKeys: String, CodingKey {
//            case sizes, text
//        }
        init(sizes: [Size], text: String) {
            self.sizes = sizes
            self.text = text
        }
    }
    
    // MARK: - Size
    class Size: Codable {
        let type: SizeType?
        let url: String

//        enum CodingKeys: String, CodingKey {
//            case type, url
//        }
        init(type: SizeType?, url: String) {
            self.type = type
            self.url = url
        }
    }
    
    enum SizeType: String, Codable {
        case k = "k"
        case l = "l"
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
    
    // MARK: - Profile
    class Profile: Codable {
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

