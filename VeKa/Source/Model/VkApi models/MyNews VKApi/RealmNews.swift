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
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
