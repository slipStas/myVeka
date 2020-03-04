//
//  GroupsRealm.swift
//  VeKa
//
//  Created by Stanislav Slipchenko on 04.03.2020.
//  Copyright © 2020 Stanislav Slipchenko. All rights reserved.
//

import Foundation
import RealmSwift

class GroupRealm: Object {
    @objc dynamic var name = ""
    @objc dynamic var photo = ""
    @objc dynamic var id = 0
    
    override class func primaryKey() -> String? {
        return "id"
    }
}
