//
//  Session.swift
//  VeKa
//
//  Created by Stanislav Slipchenko on 19.02.2020.
//  Copyright © 2020 Stanislav Slipchenko. All rights reserved.
//

import UIKit
import RealmSwift
import SwiftKeychainWrapper



class Session {
   
    enum Keys : String {
        case hardToken = "hardToken"
        case hardUserId = "hardUserId"
    }
    
    let realm = try! Realm()
    static let shared = Session()
    private init () {}
    
    var hardToken = String()
    var hardUserId = String()
    
    var login = "11"
    var password = "11"
    
}
