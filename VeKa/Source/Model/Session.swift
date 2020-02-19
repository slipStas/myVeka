//
//  Session.swift
//  VeKa
//
//  Created by Stanislav Slipchenko on 19.02.2020.
//  Copyright © 2020 Stanislav Slipchenko. All rights reserved.
//

import UIKit

class Session {
    
    static let shared = Session()
    private init () {}
    
    let token = String()
    let userId = Int()
    
    var login = ""
    var password = ""
    
}
