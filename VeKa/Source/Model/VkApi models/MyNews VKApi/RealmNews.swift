//
//  RealmNews.swift
//  VeKa
//
//  Created by Stanislav Slipchenko on 03.04.2020.
//  Copyright © 2020 Stanislav Slipchenko. All rights reserved.
//

import Foundation
import RealmSwift

class NewsRealm : Object {
    
    @objc dynamic var name = ""
    @objc dynamic var avatar = ""
    @objc dynamic var text = ""
    @objc dynamic var id = 0
    var photos = List<PhotoRealm>()
    
    override class func primaryKey() -> String? {
        return "id"
    }
}

class PhotoRealm : Object {
    
    @objc dynamic var url = ""
    @objc dynamic var width = 0
    @objc dynamic var height = 0
    @objc dynamic var aspectRatio: Int {
        return width / height
    }
}
